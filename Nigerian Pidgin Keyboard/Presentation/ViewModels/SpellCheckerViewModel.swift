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
    
    
//    func moveCursorAfterWord(_ word: String) {
//        guard let documentContextBeforeInput = textDocumentProxy.documentContextBeforeInput else {
//            return
//        }
//
//        // Find the range of the word in the text before the current input
//        if let range = documentContextBeforeInput.range(of: word, options: .backwards) {
//            // Calculate the number of characters to move the cursor to the end of the word
//            let distance = documentContextBeforeInput.distance(from: documentContextBeforeInput.endIndex, to: range.upperBound)
//            
//            // Move the cursor to the end of the word
//            textDocumentProxy.adjustTextPosition(byCharacterOffset: distance)
//        }
//    }
    
    // MARK: Listen for test updates
    private var textTimer : Timer?
    
    private func listenForTextChanges(){
        print("--- started listening for Text Changes()")
        textTimer?.invalidate()
        textTimer = nil
        
        textTimer = Timer(timeInterval: 3, repeats: true, block: { timer in
            let precedingText = self.textDocumentProxy.documentContextBeforeInput ?? ""
            let followingText = self.textDocumentProxy.documentContextAfterInput ?? ""
            let selectedText = self.textDocumentProxy.selectedText ?? ""
            let fullText = "\(precedingText)\(selectedText)\(followingText)".trimmingCharacters(in: .whitespacesAndNewlines)
            
            self.textInput = fullText
            //            print("fullText: \(fullText)")
            if(fullText == self.lastSpellCheckedSentece || fullText.isEmpty) {return}
            print("about to call spellCheck")
            Task {
                await self.spellCheck(fullText)
            }
        })
        
        if let timer = textTimer {
            RunLoop.main.add(timer, forMode: .default)
        }
    }
    
    // MARK: Check internet connection
    
    @Published var hasInternet : Bool = true
    
    func listenForInternetConnection(){
        NetworkMonitor.shared.startMonitoring { hasInternet in
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
                    self.correctionMatches = matchList.map({ match in
                        let myText = match.context.text
                        
                        let offset = match.context.offset
                        let length = match.context.length
                        
                        if let startIndex = myText.index(myText.startIndex, offsetBy: offset, limitedBy: myText.endIndex),
                           let endIndex = myText.index(startIndex, offsetBy: length, limitedBy: myText.endIndex) {
                            // Extract the substring
                            let substring = myText[startIndex..<endIndex]
                            //                            print("substring is: \(substring)")  // Output: "say"
                            
                            return match.copy(wordToBeReplace: String(substring))
                            
                            
                        }else{
                            print("else called")
                            return match
                        }
                        
                    })
                    self.lastSpellCheckedSentece = text
                    print(self.correctionMatches)
                    
                }
            }
            
        }catch {
            print(error)
        }
        
        
    }
    
    func replaceWithMatch(match : Match){
        moveCursorToEndOfText()
                print("replaceWithMatch called")
        guard let targetWord = match.wordToBeReplaced else {return}
                print("targetWord acquired : \(targetWord)")
        guard let replacementmentWord = match.replacements.first?.value else {return}
                print("replacementWord acquired : \(replacementmentWord)")
        replaceWord(targetWord: targetWord, replacementWord: replacementmentWord)
                print("placedWord called and returned")
        removeMatchFromList(match: match)
    }
    
    func ignoreMatch(match : Match) {
        
        removeMatchFromList(match: match)
    }
    
    private func removeMatchFromList(match : Match) {
        //        print("ignoreMatch has been called")
        guard let index = correctionMatches.firstIndex(of: match) else { return }
        correctionMatches.remove(at: index)
    }
    
    func moveCursorToEndOfText() {
        // Check if there's any text after the current cursor position
        if let documentContextAfterInput = textDocumentProxy.documentContextAfterInput {
            // Move the cursor forward by the length of the text after the current position
            let charactersToMove = documentContextAfterInput.count
            textDocumentProxy.adjustTextPosition(byCharacterOffset: charactersToMove)
        }
    }
    
    // Function to replace a word with another word
    private func replaceWord(targetWord: String, replacementWord: String) {
        moveCursorToEndOfText()
//        moveCursorAfterWord(targetWord)
        let precedingText = self.textDocumentProxy.documentContextBeforeInput ?? ""
        let followingText = self.textDocumentProxy.documentContextAfterInput ?? ""
        let selectedText = self.textDocumentProxy.selectedText ?? ""
        let text = "\(precedingText)\(selectedText)\(followingText)"//.trimmingCharacters(in: .whitespacesAndNewlines)
//        guard let text = textDocumentProxy.documentContextBeforeInput else { return }
        
        // Find the word in the existing text
        let newText = text.replacingOccurrences(of: targetWord, with: replacementWord)
        
        // Delete the old text
        for _ in text {
            textDocumentProxy.deleteBackward()
        }
        
        // Insert the new text
        textDocumentProxy.insertText(newText)
    }
    
}
