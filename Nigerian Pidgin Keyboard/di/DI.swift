//
//  DI.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Emmanuel Idaresit on 24/08/2024.
//

import Foundation

class DI {
    
    func initServices(){
        registerAPIs()
        registerRepositories()
    }
    
    // MARK: Register APIs
    
    private func registerAPIs() {
        ServiceLocator.shared.register(SpellCheckApiImpl(), for: SpellCheckApi.self)
    }
    
    // MARK: Register Repositories
    
    private func registerRepositories() {
        ServiceLocator.shared.register(SpellCheckRepoImpl(ServiceLocator.shared.resolve(SpellCheckApi.self)!) , for: SpellCheckRepo.self)
    }
}
