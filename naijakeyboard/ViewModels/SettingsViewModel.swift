//
//  SettingsViewModel.swift
//  naijakeyboard
//
//  Created by Emmanuel Idaresit on 25/08/2024.
//

import Foundation

class SettingsViewModel : ObservableObject {
    
    @Published var primaryServer : String = Server.s1.serverURL
    @Published var secondaryServer : String = Server.s2.serverURL
    
    init(){
        loadPreferences()
    }
    
    func loadPreferences(){
        
        //Server
        primaryServer = getPrimaryServer()
        secondaryServer = getSecondaryServer()
    }
    
    func getPrimaryServer() -> String {
        if let sharedDefaults = UserDefaults(suiteName: "group.naijakeyboard") {
            if let result = sharedDefaults.string(forKey: "primary_server"){
                return result
            }
            return Server.s1.serverURL
        }
        return Server.s1.serverURL
    }
    
    func getSecondaryServer() -> String {
        if let sharedDefaults = UserDefaults(suiteName: "group.naijakeyboard") {
            if let result = sharedDefaults.string(forKey: "secondary_server"){
                return result
            }
            return Server.s2.serverURL
        }
        return Server.s2.serverURL
    }
    
    func saveServers(primaryURL : String, secondaryURL : String){
        var primary = primaryURL.trimmingCharacters(in: .whitespacesAndNewlines)
        if !primary.hasSuffix("/") {  primary += "/"}
        var secondary = secondaryURL.trimmingCharacters(in: .whitespacesAndNewlines)
        if !secondary.hasSuffix("/") {  secondary += "/"}
        
        if (primary != primaryServer || secondary != secondaryServer){
            if let sharedDefaults = UserDefaults(suiteName: "group.naijakeyboard") {
                sharedDefaults.setValue(primary, forKey: "primary_server")
                sharedDefaults.setValue(secondary, forKey: "secondary_server")
            }
            
            primaryServer = getPrimaryServer()
            secondaryServer = getSecondaryServer()
        }
    }

    
}

