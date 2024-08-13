//
//  SettinsListItem.swift
//  naijakeyboard
//
//  Created by Hyebreed on 11/08/2024.
//

import SwiftUI

struct SettingsListItem: View {
    
    var image : String
    var title : String
    var subTitle : Bool
    
    
    var body: some View {
        HStack{
            Spacer()
                .frame(width: 16)
            ZStack{
            Image(uiImage: UIImage(named: image)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundColor(AppColors.primary)
            }
            .frame(width: 40, height: 40)
            .background(AppColors.primaryLight)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            
            VStack{
                Text(title)
                    .font(.system(size: 16, weight: Font.Weight.semibold))
                    .foregroundColor(AppColors.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                    .frame(height: 8)
                
                Text(subTitle)
                    .font(.system(size: 14, weight: Font.Weight.regular))
                    .foregroundColor(AppColors.listItemSubtitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
                .frame(width: 16)
            
            Image(systemName: "chevron.forward")
        }
    }
}

#Preview {
    SettinsListItem()
}
