//
//  SharedUserDefaults.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Emmanuel Idaresit on 08/09/2024.
//

import Foundation

class SharedUserDefaults {
    static func getUserDefaults() -> UserDefaults? {
        return UserDefaults(suiteName: "group.naijakeyboard")
    }
}
