//
//  SpellCheckRepoImpl.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Emmanuel Idaresit on 24/08/2024.
//

import Foundation

class SpellCheckRepoImpl : SpellCheckRepo {
    
    let spellCheckApi : SpellCheckApi
    
    init(_ spellCheckApi: SpellCheckApi) {
        self.spellCheckApi = spellCheckApi
    }
    
    func getCorrections(text: String) async -> Result<[Match], SpellCheckError> {
        do{
            let result = try await spellCheckApi.spellCheck(text: text)
            return .success(result)
        }catch {
            print(error)
            return .failure(SpellCheckError.unknown("\(error)"))
        }
    }
    
    
}
