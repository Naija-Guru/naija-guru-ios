//
//  NaijaKeyboardIcon.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Hyebreed on 13/08/2024.
//

import SwiftUI

struct NaijaKeyboardIconButton: View {
    let namedAsset: String?
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack{
                if(namedAsset != nil){
                    Image(uiImage: UIImage(named: namedAsset!)!)
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(KeyboardColours.primaryDark)
                }else{
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(KeyboardColours.primaryDark)
                }
            }
            .frame(width: 36, height: 36)
            .background(KeyboardColours.secondaryColor)
            .clipShape(Circle())
        }
    }
}

#Preview {
    NaijaKeyboardIconButton(namedAsset: "keyboard")
}
