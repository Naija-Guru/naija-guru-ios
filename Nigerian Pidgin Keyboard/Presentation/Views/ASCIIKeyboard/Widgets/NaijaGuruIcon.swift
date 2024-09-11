//
//  NaijaGuruIcon.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Emmanuel Idaresit on 21/08/2024.
//

import SwiftUI

struct NaijaGuruIcon: View {
    
    var errorCount : Int = 0
    var hasInternet : Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack{
                Image(uiImage: UIImage(named: "naija_guru_logo")!)
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundColor(KeyboardColours.primaryDark)
            }
            .frame(width: 36, height: 36)
            .background(KeyboardColours.secondaryColor)
            .clipShape(Circle())
        }
    }
}

#Preview {
    NaijaGuruIcon(hasInternet: true)
}
