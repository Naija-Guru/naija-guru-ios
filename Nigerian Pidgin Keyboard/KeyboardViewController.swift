//
//  KeyboardViewController.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Hyebreed on 11/08/2024.
//

import UIKit
import SwiftUI

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        let sentence = "This is an example sentence."
                let underlinedWord = "example"
                let replacementWord = "test"
                
//                let underlinedSentence = underlineWord(in: sentence, word: underlinedWord, color: .red)
//                let replacedSentence = replaceWord(in: sentence, targetWord: underlinedWord, replacementWord: replacementWord)
        
        
        // Custom Keyboard
        let customKeyboardView = NigerianPidginSpellCheckerKeyboard(textDocumentProxy: textDocumentProxy, extensionContext: extensionContext) {
            self.openApp("naijakeyboard://com.naijaguru.naijakeyboard")
        }
        
        let hostingController = HostingController(rootView: customKeyboardView) //UIHostingController(rootView: customKeyboardView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.didMove(toParent: self)

        // Constraints for SwiftUI view
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            hostingController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        
    }
    
    // Function to replace a word with another word
       func replaceWord(targetWord: String, replacementWord: String) {
           guard let text = textDocumentProxy.documentContextBeforeInput else { return }
           
           // Find the word in the existing text
           let newText = text.replacingOccurrences(of: targetWord, with: replacementWord)
           
           // Delete the old text
           for _ in text {
               textDocumentProxy.deleteBackward()
           }
           
           // Insert the new text
           textDocumentProxy.insertText(newText)
       }
    
    @objc func openURL(_ url: URL) {
           return
        }
    
    func openApp(_ urlstring:String) {

           var responder: UIResponder? = self as UIResponder
           let selector = #selector(openURL(_:))
           while responder != nil {
              if responder!.responds(to: selector) && responder != self {
                 responder!.perform(selector, with: URL(string: urlstring)!)
                 return
              }
              responder = responder?.next
            }
         }

    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}

class HostingController<Content>: UIHostingController<Content> where Content: View {
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            self.additionalSafeAreaInsets = UIEdgeInsets(top: -self.view.safeAreaInsets.top,
                                                         left: -self.view.safeAreaInsets.left,
                                                         bottom: -self.view.safeAreaInsets.bottom,
                                                         right: -self.view.safeAreaInsets.right)
        }
    }
}
