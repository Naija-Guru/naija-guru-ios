//
//  SettingsViewModel.swift
//  naijakeyboard
//
//  Created by Emmanuel Idaresit on 25/08/2024.
//

import Foundation

class SettingsViewModel : ObservableObject {
    
    @Published var currentServer : Server = Server.s1
    
    init(){
        loadPreferences()
    }
    
    func loadPreferences(){
        
        //Server
        currentServer = getCurrentServer()
    }
    
    
    func getCurrentServer() -> Server {
        if let sharedDefaults = UserDefaults(suiteName: "group.naijakeyboard") {
            if let result = sharedDefaults.string(forKey: "server"){
                return Server.fromURL(result)
            }
            return Server.s1
        }
        return Server.s1
    }//
    
    func connectServer(server : Server){
        
        if let sharedDefaults = UserDefaults(suiteName: "group.naijakeyboard") {
            sharedDefaults.setValue(server.serverURL, forKey: "server")
        }
        
        currentServer = getCurrentServer()
    }
    
}

