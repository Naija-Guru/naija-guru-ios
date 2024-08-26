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
    
    private let defaultBaseURL = "https://spellchecker-1.nl.naija.guru/"
    
    var baseURL : String {
        if let sharedDefaults = UserDefaults(suiteName: "group.naijakeyboard") {
          return  sharedDefaults.string(forKey: "server") ?? defaultBaseURL
        }
        return defaultBaseURL
    }
 
}


