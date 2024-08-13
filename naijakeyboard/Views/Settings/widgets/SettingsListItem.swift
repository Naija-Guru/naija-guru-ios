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
    var subTitle : String
    
    
    var body: some View {
        HStack{
           
            ZStack{
            Image(uiImage: UIImage(named: image)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundColor(AppColors.primary)
            }
            .frame(width: 40, height: 40)
            .background(AppColors.primaryLight)
            .clipShape(Circle())
            
            Spacer()
                .frame(width: 16)
            
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
    SettingsListItem(image: "ignore_rules", title: "Ignore Rules", subTitle: "see the list of ruels you've ignored")
}
