//
//  Alphabets.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Emmanuel Idaresit on 12/08/2024.
//

import SwiftUI

struct Alphabets: View {
    
    @State var isShiftKeyOn = true
    @State var isCapslockOn = false

    
    var alphabetWidth: CGFloat = 33
    var spacing : CGFloat
    var verticalSpace : CGFloat
    let insertText: (String) -> Void
    let backSpace: () -> Void
    
    let QWERTY: [[String]] = [
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
        ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
        ["Z", "X", "C", "V", "B", "N", "M"]
    ]
    
    let qwerty: [[String]] = [
        ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
        ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
        ["z", "x", "c", "v", "b", "n", "m"]
    ]
    
    var shouldShowUpperCase: Bool {
        return isCapslockOn ? true : isShiftKeyOn
    }
    
    func insertAlphabet(alphabet : String) -> Void {
        insertText(alphabet)
        if(!isCapslockOn){
            isShiftKeyOn = false
        }
    }

    
    var body: some View {
        VStack(spacing: verticalSpace) {
            let fontSize = shouldShowUpperCase ? 20.0 : 24.0
            HStack(spacing: spacing) {
                ForEach(0..<( shouldShowUpperCase ? QWERTY : qwerty)[0].count, id: \.self) { index in
                    CharacterButton(title: ( shouldShowUpperCase ? QWERTY : qwerty)[0][index], width: alphabetWidth, insertText: insertAlphabet, fontSize: fontSize)
                    
                }

            }
            
            HStack( alignment: .center, spacing: spacing) {
                
                ForEach(0..<( shouldShowUpperCase ? QWERTY : qwerty)[1].count, id: \.self) { index in
                    CharacterButton(title:( shouldShowUpperCase ? QWERTY : qwerty)[1][index], width: alphabetWidth, insertText: insertAlphabet, fontSize: fontSize)
                }
                
            }
            
            let fullWidth = (alphabetWidth + spacing) * 10
            let remainingWidth = fullWidth - (alphabetWidth + spacing) * 7
            let tSpecialWidth = (remainingWidth/2)-10
            
            HStack(spacing: 0) {
                Image(systemName: isCapslockOn ? "capslock.fill" : isShiftKeyOn ? "arrowshape.up.fill" : "arrowshape.up")
                    .frame(width: tSpecialWidth,height: 42)
                    .foregroundColor(.black)
                    .background( (!shouldShowUpperCase ? false : true) ? Color(hex: "ABB1BA") : Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color(hex: "888A8D"), radius: 0.5, x: 0, y: 1)
                    .onTapGesture(count: 2) {//double tap
                        isCapslockOn = !isCapslockOn
                    }
                    .onTapGesture {
                        isShiftKeyOn = !isShiftKeyOn
                        isCapslockOn = false
                    }
                
                Rectangle()
                    .fill(.clear)
                    .frame(width: 8, height: 44)
                
                HStack( spacing: spacing) {
                    
                    ForEach(0..<( shouldShowUpperCase ? QWERTY : qwerty)[2].count, id: \.self) { index in
                        CharacterButton(title: ( shouldShowUpperCase ? QWERTY : qwerty)[2][index], width: alphabetWidth, insertText: insertAlphabet, fontSize: fontSize)
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

#Preview {
    Alphabets(spacing: 33, verticalSpace: 44, insertText: {_ in }, backSpace: {})
}
