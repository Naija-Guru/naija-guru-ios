//
//  NavigationViewModel.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Emmanuel Idaresit on 23/08/2024.
//

import Foundation


class NavigationViewModel : ObservableObject {
    let openSettings : () -> Void
    
    init(openSettings: @escaping () -> Void) {
        self.openSettings = openSettings
    }
    
    @Published var showNaijakeyboard = false
    
    func toggleNaijaKeyboard(){
        showNaijakeyboard = !showNaijakeyboard
    }
    
    

   
}
