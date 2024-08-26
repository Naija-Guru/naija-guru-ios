//
//  SpellCheckRepo.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Emmanuel Idaresit on 24/08/2024.
//

import Foundation

protocol SpellCheckRepo {
    func getCorrections(text: String) async -> Result<[Match], SpellCheckError>
}
