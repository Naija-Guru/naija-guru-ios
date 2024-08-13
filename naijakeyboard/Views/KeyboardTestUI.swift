//
//  KeyboardTestUI.swift
//  naijakeyboard
//
//  Created by Hyebreed on 11/08/2024.
//

import SwiftUI

struct KeyboardTestUI: View {
    
    @State var isAlphabet = true

    
    
    var body: some View {
        
        GeometryReader{ reader in
            let rect = reader.frame(in: .global)
            let maxButtonsOnARow = 10.0
            let oneButton = rect.width / maxButtonsOnARow
            let spacing = 5.0
            let width = oneButton - spacing
            let verticalSpace = 8.0
            
            VStack{
                VStack(spacing: 0) {
                    
                    if(isAlphabet) {
                        Alphabets(alphabetWidth: width, specialButtonWidth: oneButton, spacing: spacing, verticalSpace: verticalSpace)
                    }else{
                        NumbersAndSymbols(numberWidth: width, specialButtonWidth: oneButton, spacing: spacing, verticalSpace: verticalSpace)
                    }
                    Spacer()
                        .frame(height: verticalSpace)
                    
                    HStack(spacing: spacing) {
                        Spacer().frame(width: spacing)
                        
                        SpecialButton(image: nil, title: isAlphabet ? "123" : "ABC", width: oneButton, isDark: true){
                            isAlphabet = !isAlphabet
                        }
                        
                        SpecialButton(image: "face.smiling", title: "", width: oneButton, isDark: true){
                            
                        }
                        
                        SpecialButton(image: nil, title: "space", width: rect.width / 2){
                            
                        }
                        
                        SpecialButton(image: nil, title: "return", width: rect.width / 4, isDark: true){
                            
                        }
                        
                        Spacer().frame(width: spacing)
                    }
                }
                .frame(width: rect.width, height: rect.height)
                .background(Color(hex: "D1D4D9"))
            }
        }
        
    }
}

#Preview {
    KeyboardTestUI()
}

struct NumbersAndSymbols: View {
    
    @State var isNumberLockOn = true
    
    var numberWidth: CGFloat = 33
    var specialButtonWidth: CGFloat = 33
    var spacing : CGFloat
    var verticalSpace : CGFloat
    
    let numberAndSymbols: [[String]] = [
        ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
        ["-", "/", ":", ";", "(", ")", "$", "&", "@", "\""],
        [".", ",", "?", "!", "'",]
    ]
    
    let moreSymbols: [[String]] = [
        ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="],
        ["_", "\\", "|", "~", "<", ">", "€", "£", "¥", "·"],
        [".", ",", "?", "!", "'",]
    ]

    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: spacing) {
                ForEach((isNumberLockOn ?numberAndSymbols : moreSymbols)[0], id: \.self) { key in
                    CharacterButton(title: key, width: numberWidth)
                }
            }
//
            Spacer()
                .frame(height: verticalSpace)
//
            HStack(spacing: spacing) {
                ForEach((isNumberLockOn ?numberAndSymbols : moreSymbols)[1], id: \.self) { key in
                    CharacterButton(title: key, width: numberWidth)
                }
            }
//
            Spacer()
                .frame(height: verticalSpace)
//
            HStack {
                Spacer().frame(width: spacing)
                HStack(spacing: spacing) {
                    
                    SpecialButton(image: nil, title: isNumberLockOn ? "#+=" : "123", width: specialButtonWidth, isDark: true){
                        isNumberLockOn = !isNumberLockOn
                    }
                    Spacer()
                    ForEach((isNumberLockOn ?numberAndSymbols : moreSymbols)[2], id: \.self) { key in
                        CharacterButton(title: key, width: specialButtonWidth + spacing + spacing)
                    }
                    Spacer()
                    SpecialButton(image: "delete.backward", title: "", width: specialButtonWidth, isDark: true){
                        
                    }
                    
                    
                }
                Spacer().frame(width: spacing)
            }

        }
    }
}

struct Alphabets: View {
    
    @State var isCapslockOn = true

    
    var alphabetWidth: CGFloat = 33
    var specialButtonWidth: CGFloat = 33
    var spacing : CGFloat
    var verticalSpace : CGFloat
    
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
        
        
        VStack(spacing: 0) {
            HStack(spacing: spacing) {
                ForEach(( isCapslockOn ? QUERTY : qwerty)[0], id: \.self) { key in
                    CharacterButton(title: key, width: alphabetWidth)
                }
            }
            
            Spacer()
                .frame(height: verticalSpace)
            
            HStack(spacing: spacing) {
                ForEach(( isCapslockOn ? QUERTY : qwerty)[1], id: \.self) { key in
                    CharacterButton(title: key, width: alphabetWidth)
                }
            }
            
            Spacer()
                .frame(height: verticalSpace)
            
            HStack(spacing: spacing) {
                Spacer().frame(width: spacing)
                SpecialButton(image: isCapslockOn ? "capslock.fill" : "capslock", title: "", width: specialButtonWidth, isDark: isCapslockOn ? false : true) {
                    isCapslockOn = !isCapslockOn
                }
                Spacer()
                ForEach(( isCapslockOn ? QUERTY : qwerty)[2], id: \.self) { key in
                    CharacterButton(title: key, width: alphabetWidth)
                }
                Spacer()
                SpecialButton(image: "delete.backward", title: "", width: specialButtonWidth, isDark: true){
                    
                }
                Spacer().frame(width: spacing)
                
            }
        }
    }
}

struct CharacterButton: View {
    let title: String
    var width: CGFloat = 33
    
    var body: some View {
        Button(action: {
//            //            // Handle key press
//            //            if let proxy = UIApplication.shared.windows.first?.rootViewController?.view.inputView?.superview?.next as? UIInputViewController {
//            //                proxy.textDocumentProxy.insertText(self.title)
//            //            }
        }, label: {
            Text(title)
            .font(.system(size: 18))
                .frame(width: width,height: 44)
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(4)
                .shadow(color: Color(hex: "888A8D"), radius: 0.5, x: 0, y: 1)
        })
    }
}

struct SpecialButton: View {
    let image: String?
    let title: String
    var width: CGFloat = 33
    var isDark: Bool = false
    var onTap: () -> Void
    
    var body: some View {
        Button(action: onTap, label: {
            if(image != nil){
                Image(systemName: image!)
                    .frame(width: width,height: 44)
                    .foregroundColor(.black)
                    .background( isDark ? Color(hex: "ABB1BA") : Color.white)
                    .cornerRadius(4)
                    .shadow(color: Color(hex: "888A8D"), radius: 0.5, x: 0, y: 1)
            }else{
                Text(title)
                    .font(.system(size: 14))
                    .frame(width: width,height: 44)
                    .foregroundColor(.black)
                    .background( isDark ? Color(hex: "ABB1BA") : Color.white)
                    .cornerRadius(4)
                    .shadow(color: Color(hex: "888A8D"), radius: 0.5, x: 0, y: 1)
            }
        })
    }
}
