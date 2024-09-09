//
//  SettingsViewModel.swift
//  naijakeyboard
//
//  Created by Emmanuel Idaresit on 25/08/2024.
//

import Foundation

class SettingsViewModel : ObservableObject {
    
    @Published var ignoreRules : [IgnoreRule] = []
    
    @Published var primaryServer : String = Server.s1.serverURL
    @Published var secondaryServer : String = Server.s2.serverURL
    
    init(_ isPreview : Bool = false){
        loadPreferences()
        
        if(isPreview){
            ignoreRules = [IgnoreRule(id: "DETERMINERS_MISSPELLING", ruleType: IgnoreRuleType.rule, dateTime: Date()),
             IgnoreRule(id: "PERSONAL_PRONOUNS_MISSPELLING", ruleType: IgnoreRuleType.rule, dateTime: Date()),
             IgnoreRule(id: "ADVERBS_MISSPELLING", ruleType: IgnoreRuleType.rule, dateTime: Date()),
             IgnoreRule(id: "ORTHOGRAPHIC_ERRORS", ruleType: IgnoreRuleType.category, dateTime: Date())]
        }
    }
    
    func loadPreferences(){
        
        // Ignore rules
        ignoreRules = getAllIgnoreRules()
        
        //Server
        primaryServer = getPrimaryServer()
        secondaryServer = getSecondaryServer()
    }
    
    // MARK: Ignore Rules
    
    func getAllIgnoreRules() -> [IgnoreRule] {
        
        if let userDefaults = UserDefaults(suiteName: "group.naijakeyboard") {
            if let result  = userDefaults.array(forKey: IgnoreRule.getKey()) as! [[String : Any]]?{
                let ignoreAllList = result.map { d in
                    return IgnoreRule.fromDictionary(d)
                }
                return ignoreAllList
            }
            return []
            
        }
        return []
    }
    
    func removeIgnoreRule(ignoreRule : IgnoreRule){
        if let userDefaults = UserDefaults(suiteName: "group.naijakeyboard") {
            var tempList = ignoreRules
            tempList.removeAll { ig in ig.id == ignoreRule.id}
            userDefaults.setValue(tempList.map({ i in i.toDictionary() }), forKey: IgnoreRule.getKey())
            ignoreRules = getAllIgnoreRules()
        }
    }
    
    // MARK: Servers
    
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

