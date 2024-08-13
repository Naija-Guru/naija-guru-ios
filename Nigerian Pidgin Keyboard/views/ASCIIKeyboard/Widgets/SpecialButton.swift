//
//  SpecialButton.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Hyebreed on 12/08/2024.
//

import SwiftUI

struct SpecialButton: View {
    
    let image: String?
    let title: String
    var width: CGFloat = 33
    var isDark: Bool = false
    var assetImage: String?
    var onTap: () -> Void
    
    
    var body: some View {
        Button(action: onTap, label: {
            if(assetImage != nil){
                ZStack{
                    Image(uiImage: UIImage(named: assetImage!)!)
//                Image(assetImage!)
                        .resizable()
                    .frame(width: 24,height: 24)
                    .foregroundColor(.black)
            }
                .frame(width: width,height: 42)
                    .background( isDark ? Color(hex: "ABB1BA") : Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color(hex: "888A8D"), radius: 0.5, x: 0, y: 1)
            }else
            if(image != nil){
                
                Image(systemName: image!)
                    .frame(width: width,height: 42)
                    .foregroundColor(.black)
                    .background( isDark ? Color(hex: "ABB1BA") : Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color(hex: "888A8D"), radius: 0.5, x: 0, y: 1)
            }else{
                Text(title)
                    .font(.system(size: 16))
                    .frame(width: width,height: 42)
                    .foregroundColor(.black)
                    .background( isDark ? Color(hex: "ABB1BA") : Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color(hex: "888A8D"), radius: 0.5, x: 0, y: 1)
            }
        })
    }
}

//#Preview {
//    SpecialButton()
//}
