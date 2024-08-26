//
//  NigerianPidginSpellCheckerKeyboard.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Emmanuel Idaresit on 11/08/2024.
//

import SwiftUI

struct MainView: View {
   
    @EnvironmentObject private var navigationVM : NavigationViewModel
    @EnvironmentObject private var spellCheckerVM : SpellCheckerViewModel

//    init(textDocumentProxy: UITextDocumentProxy, openSettings: @escaping () -> Void) {
//        self.spellCheckerViewModel.setTextDocumntProxy(textDocumentProxy: textDocumentProxy)
//        self.navigationViewModel.openSettings = openSettings
//    }
    
    
    var body: some View {
        
        if(navigationVM.showNaijakeyboard){
            NaijaKeyboard()
            .frame(height: 252)
            .environmentObject(navigationVM)
            .environmentObject(spellCheckerVM)
        }else{
            
            ASCIIKeyboard()
            .frame(height: 252)
            .environmentObject(navigationVM)
            .environmentObject(spellCheckerVM)
        }
        
    }
}

//#Preview {
//    NigerianPidginSpellCheckerKeyboard { text in
//
//    }
//}
