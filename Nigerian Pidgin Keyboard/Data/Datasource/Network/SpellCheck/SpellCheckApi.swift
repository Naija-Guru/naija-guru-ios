//
//  SpellCheckAPi.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Emmanuel Idaresit on 23/08/2024.
//

import Foundation

protocol SpellCheckApi {
    func spellCheck(text : String) async throws -> [Match]
}

class SpellCheckApiImpl : SpellCheckApi {
    
    func spellCheck(text : String) async throws -> [Match] {
        let url = URL(string: "\(ApiClient.shared.baseURL)v2/check?language=pcm-NG&text=\(text)")!
        print("url: \(url.absoluteURL)")
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(SpellCheckResponse.self, from: data)
        
        return decoded.matches
    }
    
}
