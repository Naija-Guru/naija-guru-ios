//
//  NaijaKeyboard.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Hyebreed on 13/08/2024.
//

import SwiftUI

struct NaijaKeyboard: View {
    
    let extensionContext : NSExtensionContext?
    let openSettings : () -> Void
    var hideNaijaKeyboard : () -> Void
    
//    @objc func openApp() {
//            if let url = URL(string: "myapp://openPage") {
//                self.extensionContext?.open(url, completionHandler: nil)
//            }
//        }
    
    var body: some View {
        VStack{
            
            Spacer()
            
            Text("Start writting...")
                .font(.system(size: 16))
                .foregroundColor(.black)
            
            Spacer()
                .frame(height: 16)
            
            Image("start_writing")
                .resizable()
                .frame(width: 108, height: 120)
                
            Spacer()
            
            
            HStack(spacing: 0){
                
                NaijaKeyboardIconButton(namedAsset: "keyboard")
                    .padding(.leading, 12)
                    .onTapGesture {
                        hideNaijaKeyboard()
                    }
                   
                
                Spacer()
                
                Text("0 writing issue found")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex:"8E8E93"))
                Spacer()
                
                NaijaKeyboardIconButton(namedAsset: nil)
                .padding(.trailing, 12)
                .onTapGesture {
                    print("tap settings")
                    openSettings()
                }
                
            }
            .padding(.bottom, 10)
        }
        .background(Color(hex: "F0FAF4"))
    }//view
}

//#Preview {
//    NaijaKeyboard()
//}
