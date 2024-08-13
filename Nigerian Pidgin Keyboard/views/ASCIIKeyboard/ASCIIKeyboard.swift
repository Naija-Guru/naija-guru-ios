//
//  ASCIIKeyboard.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Hyebreed on 12/08/2024.
//

import SwiftUI

struct ASCIIKeyboard: View {
    
    
    @State var isAlphabet = true
    @State var showEmojis = false
    let textDocumentProxy : UITextDocumentProxy
    let showNaijaKeyboard : () -> Void
    
    func insertText(_ text : String){
        textDocumentProxy.insertText(text)
    }
    
    func backSpace(){
        textDocumentProxy.deleteBackward()
    }
    
    var body: some View {
        
        GeometryReader{ reader in
            let rect = reader.frame(in: .global)
            let maxButtonsOnARow = 10.0
            let oneButton = rect.width / maxButtonsOnARow
            let spacing = 6.0
            let width = oneButton - spacing
            let verticalSpace = 10.0
            let specialButtonWidth = oneButton + (oneButton / 5)
            
            if showEmojis {
                Emojis(showAlphabetKeyboard: {showEmojis = !showEmojis}, insertText: insertText, backSpace: backSpace)
            }
            else{
                //            VStack{
                VStack(spacing: 0) {
                    
                    HStack(spacing: 0){
                        
                        NaijaKeyboardIcon()
                        .padding(.leading, 12)
                        .onTapGesture {
                            showNaijaKeyboard()
                        }
                        
                        Spacer()
                    }
                    
                    .frame(height: 50)
                    .background( Color(hex: "D1D4D9"))
                    
                    if(isAlphabet) {
                        Alphabets(alphabetWidth: width, spacing: spacing, verticalSpace: verticalSpace, insertText: insertText, backSpace: backSpace)
                            .frame(maxWidth: .infinity)
                    }else{
                        NumbersAndSymbols(numberWidth: width, specialButtonWidth: specialButtonWidth, spacing: spacing, verticalSpace: verticalSpace, insertText: insertText, backSpace: backSpace)
                    }
                    Spacer()
                        .frame(height: verticalSpace)
                    
                    let spaceBarWidth = width * 5 + spacing * 4
                    let alphaNumbericWidth = width + spacing * 2
                    let emojiWidth = width + width * 0.5
                    let returnWidth = width * 2 + width * 0.5
                    
                    HStack(spacing: spacing ) {
                        //                        Spacer().frame(width: spacing)
                        
                        SpecialButton(image: nil, title: isAlphabet ? "123" : "ABC", width: alphaNumbericWidth, isDark: true){
                            isAlphabet = !isAlphabet
                        }
                        
                        SpecialButton(image: nil, title: "", width: emojiWidth, isDark: true, assetImage: "emoji_face"){
                            showEmojis = !showEmojis
                        }
                        
                        SpecialButton(image: nil, title: "space", width: spaceBarWidth){
                            insertText(" ")
                        }
                        
                        SpecialButton(image: nil, title: "return", width: returnWidth, isDark: true){
                            insertText("\n")
                        }
                    }
                }
                .frame(width: rect.width)
            }
            
            //            }
        }
        
    }
}

//#Preview {
//    ASCIIKeyboard()
//}
