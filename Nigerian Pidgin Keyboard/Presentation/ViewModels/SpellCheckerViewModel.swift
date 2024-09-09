//
//  SpellCheckerViewModel.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Emmanuel Idaresit on 23/08/2024.
//

import Foundation
import UIKit

class SpellCheckerViewModel : NSObject, ObservableObject {
    
    // MARK: dependencies
    private let textDocumentProxy : UITextDocumentProxy
    let spellCheckRepo : SpellCheckRepo = ServiceLocator.shared.resolve(SpellCheckRepo.self)!
    
    init(textDocumentProxy: UITextDocumentProxy) {
        self.textDocumentProxy = textDocumentProxy
        super.init()
        self.listenForTextChanges()
        self.listenForInternetConnection()
    }
    
    
    func insertText(_ text : String){
        textDocumentProxy.insertText(text)
    }
    
    func deleteBackward(){
        textDocumentProxy.deleteBackward()
    }
    
    
    
    // MARK: retrieved text from text field and move cursor
    
    private var pauseLoop = false // pauses the listen for text changes timer
    
    private func moveCursorToEndOfSentence() {
        // Check if there's any text after the current cursor position
        if let documentContextAfterInput = textDocumentProxy.documentContextAfterInput {
            // Move the cursor forward by the length of the text after the current position
            let charactersToMove = documentContextAfterInput.count
            textDocumentProxy.adjustTextPosition(byCharacterOffset: charactersToMove)
        }
    }
    
      
    private func moveCursorToEndOfFullDocumentContext(){
        pauseLoop = true // to stop the searchTimer from scanning the document
        searchThread.suspend() // to release values in the search thread to be used in this thread
        
        
        var after = self.textDocumentProxy.documentContextAfterInput
        while (after != nil && !after!.isEmpty){
            
            textDocumentProxy.adjustTextPosition(byCharacterOffset: after?.count ?? 0)
            Thread.sleep(forTimeInterval: 0.01)
            after = textDocumentProxy.documentContextAfterInput
        }
        
        pauseLoop = false
        searchThread.resume()
    }
    
    private func currentSentence() -> String {
        let textBeforeCursor = textDocumentProxy.documentContextBeforeInput ?? ""
        let selectedText = textDocumentProxy.selectedText ?? ""
        let textAfterCursor = textDocumentProxy.documentContextAfterInput ?? ""
        
        let fullSentence = "\(textBeforeCursor)\(selectedText)\(textAfterCursor)"
        return fullSentence
    }

    
    private func fullDocumentContext() -> String {
        let textDocumentProxy = self.textDocumentProxy

        var before = textDocumentProxy.documentContextBeforeInput

        var completePriorString = "";
        
        // Grab everything before the cursor
        while (before != nil && !before!.isEmpty) {
            completePriorString = before! + completePriorString
            
            let length = (before?.count ?? 1)
            textDocumentProxy.adjustTextPosition(byCharacterOffset: -length)
            Thread.sleep(forTimeInterval: 0.01)
            before = textDocumentProxy.documentContextBeforeInput
        }
        
        // Move the cursor back to the original position
        self.textDocumentProxy.adjustTextPosition(byCharacterOffset: completePriorString.count)
        Thread.sleep(forTimeInterval: 0.01)

        var after = textDocumentProxy.documentContextAfterInput

        var completeAfterString = "";
        
        // Grab everything after the cursor
        while (after != nil && !after!.isEmpty) {
            completeAfterString += after!

            let length = after!.lengthOfBytes(using: String.Encoding(rawValue: NSUTF8StringEncoding))

            textDocumentProxy.adjustTextPosition(byCharacterOffset: length)
            Thread.sleep(forTimeInterval: 0.01)
            after = textDocumentProxy.documentContextAfterInput
        }

        // Go back to the original cursor position
        self.textDocumentProxy.adjustTextPosition(byCharacterOffset: -(completeAfterString.count))

        let completeString = completePriorString + completeAfterString

        return completeString
    }
    

    
    // MARK: Listen for text updates
    private var textTimer : Timer?
    private var searchThread = DispatchQueue(label: "com.naija.keyboard1")
    var naijakeyboardISShowing = false
    var showLoading = false
    
    func maybeShowLoading(){
        if(!correctionMatches.isEmpty) {return}
        showLoading = true
    }
    
    private func listenForTextChanges(){
        print("--- started listening for Text Changes()")
        textTimer?.invalidate()
        textTimer = nil
        
        textTimer = Timer(timeInterval: 3, repeats: true, block: { timer in
            self.processNewText()

        })
        
        if let timer = textTimer {
            RunLoop.main.add(timer, forMode: .default)
        }
    }
    
    private func processNewText(){
        searchThread.async {
            if (self.pauseLoop) {return}
            let text = self.naijakeyboardISShowing ? self.fullDocumentContext() : self.currentSentence()
            
            DispatchQueue.main.async {
                self.textInput = text
                
                if(text == self.lastSpellCheckedSentece) {
                    self.showLoading = false
                    return
                }
                if(text.isEmpty){
                    self.textInput = ""
                    self.correctionMatches.removeAll()
                    self.lastSpellCheckedSentece = ""
                    self.showLoading = false
                    return
                }
                print("about to call spellCheck")
                Task {
                    await self.spellCheck(text)
                }
            }
            
        }
    }//processNewText
    
   
    
    // MARK: Check internet connection
    
    @Published var hasInternet : Bool = true
    
    func listenForInternetConnection(){
        NetworkMonitor.shared.startMonitoring { hasInternet in
            print("has internet connection : \(hasInternet)")
            self.hasInternet = hasInternet
        }
    }
    
    
    // MARK: Fetch Spell Checks
    @Published var correctionMatches : [Match] = []
    @Published var textInput : String = ""
    private var lastSpellCheckedSentece : String = ""
    
    private func spellCheck(_ text : String) async {
        print("Spell Check called")
        print("Sentence: \(text)")
        let result = await spellCheckRepo.getCorrections(text: text)
        do{
            let matchList : [Match] = try result.get()
            
            if text != lastSpellCheckedSentece {
                DispatchQueue.main.async {
                    var tempCorrectionMatches : [Match] = matchList.map({ match in
                        let myText = match.context.text
                        
                        let offset = match.context.offset
                        let length = match.context.length
                        
                        if let startIndex = myText.index(myText.startIndex, offsetBy: offset, limitedBy: myText.endIndex),
                           let endIndex = myText.index(startIndex, offsetBy: length, limitedBy: myText.endIndex) {
                            // Extract the substring
                            let substring = myText[startIndex..<endIndex]
                            
                            return match.copy(wordToBeReplace: String(substring))
                            
                            
                        }else{
                            return match
                        }
                        
                    })
                    print(tempCorrectionMatches)
                    Task {
                     await self.filterListAndUpdate(list: tempCorrectionMatches)
                    }
                    self.lastSpellCheckedSentece = text
                    print(self.correctionMatches)
                    self.showLoading = false
                }
            }
            
        }catch {
            print(error)
        }
        
        
    }
    
    private func filterListAndUpdate(list: [Match]) async {
        let ignoreListResult = await spellCheckRepo.getAllIgnoreRules()
        DispatchQueue.main.async {
            var tempCorrectionMatches = list
            do {
                let ignoreList = try ignoreListResult.get()
                for ignoreRule in ignoreList {
                    for match in tempCorrectionMatches {
                        tempCorrectionMatches.removeAll { d in d.rule.id == ignoreRule.id || d.rule.category.id == ignoreRule.id }
                    }
                }
            }catch{
                print(error)
            }
            
            self.correctionMatches = tempCorrectionMatches
        }
    }
    
    func replaceWithMatch(match : Match){
                print("replaceWithMatch called")
        guard let targetWord = match.wordToBeReplaced else {return}
                print("targetWord acquired : \(targetWord)")
        guard let replacementmentWord = match.replacements.first?.value else {return}
                print("replacementWord acquired : \(replacementmentWord)")
        replaceWord(targetWord: targetWord, replacementWord: replacementmentWord)
                print("placedWord called and returned")
        removeMatchFromList(match: match)
    }
    
    
    func ignoreRule(match : Match){
        let ignoreRule = IgnoreRule(id: match.rule.id, ruleType: IgnoreRuleType.rule, displayTitle: match.rule.description, dateTime: Date())
        Task{
            let result = await spellCheckRepo.addIgnoreRule(ignoreRule)
            do{
                let hasIgnored = try result.get()
                print("has ignored rule : \(hasIgnored)")
            }catch {
                print("ignore rule error: \(String(describing:  error))")
            }
        }
        removeMatchFromList(match: match)
    }
    
    func ignoreCategory(match : Match){
        let ignoreRule = IgnoreRule(id: match.rule.category.id, ruleType: IgnoreRuleType.category, displayTitle: match.rule.category.name, dateTime: Date())
        Task{
            let result = await spellCheckRepo.addIgnoreRule(ignoreRule)
            do{
                let hasIgnored = try result.get()
                print("has ignored category : \(hasIgnored)")
            }catch {
                print("ignore category error: \(String(describing:  error))")
            }
        }
        removeMatchFromList(match: match)
    }
    
    private func removeMatchFromList(match : Match) {
        guard let index = correctionMatches.firstIndex(of: match) else { return }
        correctionMatches.remove(at: index)
    }
    
    
    // Function to replace a word with another word
    private func replaceWord(targetWord: String, replacementWord: String) {
        DispatchQueue(label: "com.naija.keyboard1").async {
            self.naijakeyboardISShowing ? self.moveCursorToEndOfFullDocumentContext() : self.moveCursorToEndOfSentence()
            
            DispatchQueue.main.async {
                
                let text =  self.textInput
                print("before replacement: \(text)")
                // Find the word in the existing text
                let newText = text.replacingOccurrences(of: targetWord, with: replacementWord)
                
                print("after replacement: \(newText)")
                // Delete the old text
                for _ in text {
                    self.textDocumentProxy.deleteBackward()
                }
                
                // Insert the new text
                self.textDocumentProxy.insertText(newText)
            }
        }
        
    }
    
}
