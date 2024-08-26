//
//  KeyboardColours.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Emmanuel Idaresit on 12/08/2024.
//

import Foundation

import Foundation
import SwiftUI

class KeyboardColours {
    //todo: font family
    
    static var primary = Color(hex: "0E3F30")
    static var primaryDark = Color(hex:"0E3F30")
    static var primaryLight = Color(hex: "C5EBDC")
    static var primaryLightOnWhite = Color(hex: "E9F5F2")
    
    static var secondaryColor = Color(hex: "EDEAE4")
    
    static var wrongSpelling = Color(hex: "FF7A75")
    static var correctSpelling = Color(hex: "335DE3")
    

    static var dividerColor =  Color(hex: "545458")//.withOpacity(.56);

    static var subTitle =  Color(hex: "EBEBF5")//.withOpacity(.6);

    static var buttonGray = Color(hex: "242424")
    
    static var borderColor = Color(hex: "E5E5EA")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0

        scanner.scanHexInt64(&rgb)

        self.init(
                    red: Double((rgb & 0xFF0000) >> 16) / 255.0,
                    green: Double((rgb & 0x00FF00) >> 8) / 255.0,
                    blue: Double(rgb & 0x0000FF) / 255.0
                )
            }
}
