//
//  RoundedRectangleShape.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Hyebreed on 02/09/2024.
//

import Foundation
import SwiftUI

struct RoundedCornersShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}