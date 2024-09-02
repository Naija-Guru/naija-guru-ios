//
//  QuickFunctions.swift
//  naijakeyboard
//
//  Created by Hyebreed on 01/09/2024.
//

import Foundation
import UIKit

//func isValidURL(_ urlString: String) -> Bool {
//    let urlRegEx = "((https|http)://)((www.)?|((\\w|\\-)+)\\.)(\\w+)(\\.[a-z]{2,})?(/.*)?"
////    let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
//    let urlTest = NSPredicate(format: "SELF MATCHES %@", urlRegEx)
//    return urlTest.evaluate(with: urlString)
//}

func isValidURL(_ urlString: String) -> Bool {
    if let url = URL(string: urlString) {
        return UIApplication.shared.canOpenURL(url)
    }
    return false
}

