//
//  ASCIIKeyboard.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Emmanuel Idaresit on 12/08/2024.
//

import SwiftUI

struct ASCIIKeyboard: View {
    
    @EnvironmentObject private var navigationVM : NavigationViewModel
    @EnvironmentObject private var spellCheckerVM : SpellCheckerViewModel
    
    @State var isAlphabet = true
    @State var showEmojis = false
    
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
                EmojiKeypad(showAlphabetKeyboard: {showEmojis = !showEmojis}, insertText: spellCheckerVM.insertText, backSpace: spellCheckerVM.deleteBackward)
            }
            else{
                
                VStack(spacing: 0) {
                    
                    HStack(spacing: 0){
                        
                        NaijaGuruIcon(errorCount: spellCheckerVM.hasInternet ? spellCheckerVM.correctionMatches.count : 0, hasInternet: spellCheckerVM.hasInternet)
                            .padding(.leading, 12)
                            .onTapGesture {
                                navigationVM.toggleNaijaKeyboard()
                                spellCheckerVM.naijakeyboardISShowing = true
                            }
                        Spacer()
                            .frame(width: 20)
                        
                        if(!spellCheckerVM.correctionMatches.isEmpty && spellCheckerVM.hasInternet){
                            if let first = spellCheckerVM.correctionMatches.first{
                                Button(action:{
                                    spellCheckerVM.replaceWithMatch(match: first)
                                }){
                                    VStack(alignment:.leading) {
                                        Text(first.rule.category.name)
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(Color(hex: "747474"))
                                            .padding(.top, 4)
                                            .padding(.horizontal, 6)
                                        
                                        Text(first.replacements.first?.value ?? "")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(KeyboardColours.primary)
                                            .padding(.bottom, 4)
                                            .padding(.horizontal, 6)
                                    }
                                    .background(.white)
                                    .clipShape(RoundedCornersShape(corners: .allCorners, radius: 3))
                                }
                            }
                        }
                        Spacer()
                    }
                    
                    .frame(height: 50)
                    .background( Color(hex: "D1D4D9"))
                    
                    if(isAlphabet) {
                        Alphabets(alphabetWidth: width, spacing: spacing, verticalSpace: verticalSpace, insertText: spellCheckerVM.insertText, backSpace: spellCheckerVM.deleteBackward)
                            .frame(maxWidth: .infinity)
                    }else{
                        NumbersAndSymbols(numberWidth: width, specialButtonWidth: specialButtonWidth, spacing: spacing, verticalSpace: verticalSpace, insertText: spellCheckerVM.insertText, backSpace: spellCheckerVM.deleteBackward)
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
                            //                            insertText(" ")
                            spellCheckerVM.insertText(" ")
                        }
                        
                        SpecialButton(image: nil, title: "return", width: returnWidth, isDark: true){
                            //                            insertText("\n")
                            spellCheckerVM.insertText("\n")
                        }
                    }
                }
                .frame(width: rect.width)
            }
            
            
        }
        .background( Color(hex: "D1D4D9"))
        
    }
}

#Preview {
    ASCIIKeyboard()
}
