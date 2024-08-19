//
//  NaijaKeyboardIcon.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Hyebreed on 13/08/2024.
//

import SwiftUI

struct NaijaKeyboardIcon: View {
    let errorCount : Int = 0
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack{
                Image(uiImage: UIImage(named: "keyboard")!)
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundColor(KeyboardColours.primaryDark)
            }
            .frame(width: 36, height: 36)
            .background(KeyboardColours.primaryLight)
            .clipShape(Circle())
            // Badge
            if errorCount > 0 {
                Text("3")
                    .font(.system(size: 14, weight: Font.Weight.medium))
                    .foregroundColor(.white)
                    .padding(5)
                    .background(KeyboardColours.primaryDark)
                    .clipShape(Circle())
                    .offset(x: 10, y: -10)
            }
        }
    }
}

#Preview {
    NaijaKeyboardIcon()
}
