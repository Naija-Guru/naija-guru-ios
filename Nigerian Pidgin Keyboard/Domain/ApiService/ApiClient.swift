//
//  ApiService.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Emmanuel Idaresit on 23/08/2024.
//

import Foundation

class ApiClient {
    static let shared = ApiClient()
    private init(){
        //
    }
    
    private let defaultPrimaryURL = "https://spellchecker-1.nl.naija.guru/"
    private let defaultSecondaryURL = "https://spellchecker-1.de.naija.guru/"
    
    var primaryURL : String {
        if let sharedDefaults = UserDefaults(suiteName: "group.naijakeyboard") {
          return  sharedDefaults.string(forKey: "primary_server") ?? defaultPrimaryURL
        }
        return defaultPrimaryURL
    }
    
    var secondaryURL : String {
        if let sharedDefaults = UserDefaults(suiteName: "group.naijakeyboard") {
          return  sharedDefaults.string(forKey: "secondary_server") ?? defaultSecondaryURL
        }
        return defaultSecondaryURL
    }
 
}


