//
//  CharacterButton.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Hyebreed on 12/08/2024.
//

import SwiftUI

struct CharacterButton: View {
    let title: String
    var width: CGFloat = 33
    let insertText: (String) -> Void
    var fontSize : CGFloat = 20
    
    var body: some View {
        Button(action: {
            insertText(title)
        }, label: {
            Text(title)
            .font(.system(size: fontSize))
                .frame(width: width,height: 42)
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(5)
                .shadow(color: Color(hex: "888A8D"), radius: 0.5, x: 0, y: 1)
        })
    }
}

//#Preview {
//    CharacterButton()
//}
