//
//  NigerianPidginSpellCheckerKeyboard.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Hyebreed on 11/08/2024.
//

import SwiftUI

struct NigerianPidginSpellCheckerKeyboard: View {
    @State var showNaijakeyboard = false
    let textDocumentProxy : UITextDocumentProxy
    let extensionContext : NSExtensionContext?
    let openSettings : () -> Void
    
    
    var body: some View {
        
        if(showNaijakeyboard){
            NaijaKeyboard(extensionContext: extensionContext, openSettings: openSettings, hideNaijaKeyboard: {
                showNaijakeyboard = false
            })
            .frame(height: 252)
        }else{
            
            ASCIIKeyboard(textDocumentProxy: textDocumentProxy){
                showNaijakeyboard = !showNaijakeyboard
            }
            .frame(height: 252//208
            )
            .padding(0)
            .background( Color(hex: "D1D4D9"))
        }
        
    }
}

//#Preview {
//    NigerianPidginSpellCheckerKeyboard { text in
//
//    }
//}
