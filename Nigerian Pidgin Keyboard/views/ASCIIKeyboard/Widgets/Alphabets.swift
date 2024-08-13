//
//  Alphabets.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Hyebreed on 12/08/2024.
//

import SwiftUI

struct Alphabets: View {
    
    @State var isCapslockOn = true

    
    var alphabetWidth: CGFloat = 33
//    var specialButtonWidth: CGFloat = 33
    var spacing : CGFloat
    var verticalSpace : CGFloat
    let insertText: (String) -> Void
    let backSpace: () -> Void
    
    let QUERTY: [[String]] = [
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
        ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
        ["Z", "X", "C", "V", "B", "N", "M"]
    ]
    
    let qwerty: [[String]] = [
        ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
        ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
        ["z", "x", "c", "v", "b", "n", "m"]
    ]

    
    var body: some View {
        VStack(spacing: verticalSpace) {
            let fontSize = isCapslockOn ? 20.0 : 24.0
            HStack(spacing: spacing) {
                ForEach(0..<( isCapslockOn ? QUERTY : qwerty)[0].count, id: \.self) { index in
                    CharacterButton(title: ( isCapslockOn ? QUERTY : qwerty)[0][index], width: alphabetWidth, insertText: insertText, fontSize: fontSize)
                    
                }

            }
            
            HStack( alignment: .center, spacing: spacing) {
                
                ForEach(0..<( isCapslockOn ? QUERTY : qwerty)[1].count, id: \.self) { index in
                    CharacterButton(title:( isCapslockOn ? QUERTY : qwerty)[1][index], width: alphabetWidth, insertText: insertText, fontSize: fontSize)
                }
                
            }
            
            let fullWidth = (alphabetWidth + spacing) * 10
            let remainingWidth = fullWidth - (alphabetWidth + spacing) * 7
            let tSpecialWidth = (remainingWidth/2)-10
            
            HStack(spacing: 0) {
                //"capslock.fill" : "capslock"
                SpecialButton(image: isCapslockOn ? "arrowshape.up.fill" : "arrowshape.up", title: "", width: tSpecialWidth, isDark: isCapslockOn ? false : true) {
                    isCapslockOn = !isCapslockOn
                }
                
                Rectangle()
                    .fill(.clear)
                    .frame(width: 8, height: 44)
                
                HStack( spacing: spacing) {
                    
                    ForEach(0..<( isCapslockOn ? QUERTY : qwerty)[2].count, id: \.self) { index in
                        CharacterButton(title: ( isCapslockOn ? QUERTY : qwerty)[2][index], width: alphabetWidth, insertText: insertText, fontSize: fontSize)
                    }
                    
                }
                
                Rectangle()
                    .fill(.clear)
                    .frame(width: 8, height: 44)
                
                SpecialButton(image: "delete.backward", title: "", width: tSpecialWidth, isDark: true){
                    backSpace()
                }

            }
            
        }
    }
}

//#Preview {
//    Alphabets()
//}
