//
//  HomeView.swift
//  naijakeyboard
//
//  Created by Hyebreed on 11/08/2024.
//

import SwiftUI

struct HomeView: View {
    
//    @State private var navigateToPage = false
    
    var body: some View {
        
        VStack{

                Image("naija_guru_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 77, height: 92)

            //
            Spacer()
                .frame(height: 30)
            
            Text("Welcome to Naija Keyboard")
                .font(.system(size: 26, weight: Font.Weight.semibold))
                .foregroundColor(AppColors.title)
            
            Spacer()
                .frame(height: 8)
            
            
            Text("Get your Naija Pidgin grammar on point...")
                .font(.system(size: 18, weight: Font.Weight.regular))
                .foregroundColor(AppColors.headerSubtitle)
            
            Spacer()
                .frame(height: 48)
            
            EnableKeyboardView()
            
            Spacer()
                .frame(height: 40)
            
            NavigationLink(destination:  SettingsView(), label: {
                HStack(){
                    ZStack{
                        Image(systemName: "gear")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 28, height: 28)
                            .foregroundColor(AppColors.primary)
                        
                    }
                    .frame(width: 44, height: 44)
                    .background(AppColors.primaryLight)
                    .cornerRadius(20)
                    
                    Text("Settings")
                        .font(.system(size: 16, weight: Font.Weight.semibold))
                        .foregroundColor(Color(hex:"292C32"))
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 75)
                .background(.white)
                .clipShape( RoundedCornersShape(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10))
                .shadow(color: Color.gray.opacity(0.2), radius: 12, x: 0, y: 0)
            })
            
        }.padding(.horizontal, AppDimensions.pageMargin)
          
    }//view
}

#Preview {
    HomeView()
}

