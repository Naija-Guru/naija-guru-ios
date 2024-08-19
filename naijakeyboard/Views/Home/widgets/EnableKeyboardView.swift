//
//  EnableKeyboardView.swift
//  naijakeyboard
//
//  Created by Hyebreed on 11/08/2024.
//

import SwiftUI

struct EnableKeyboardView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            
            VStack(alignment: .leading) {
                Text("Enable the keyboard")
                    .font(.system(size:16, weight: Font.Weight.semibold))
                    .foregroundColor(AppColors.title)
                    .padding(.horizontal, 10)
                
                Spacer()
                    .frame(height: 8)
                
                
                Text("The necessary permissions to run this app.")
                    .font(.system(size: 14, weight: Font.Weight.regular))
                    .foregroundColor(AppColors.headerSubtitle)
                    .padding(.horizontal, 10)
            }
            
            Spacer()
                .frame(height: 32)
            
            
            ZStack(alignment: .bottom){
                GifImage("instructions_gif")
                    .padding(40)
                    .clipShape(RoundedCornersShape(corners: [.topLeft, .topRight], radius: 10))
                    .overlay {
                        RoundedCornersShape(corners: [.topLeft, .topRight], radius: 10)
                            .fill(LinearGradient(gradient: Gradient(colors: [ Color.clear, Color.white]),
                                             startPoint: .top,
                                             endPoint: .bottom))
                    }
                    
                
                Button(action: {
                    openSettings()
                }, label: {
                    Text("Enable")
                        .foregroundColor(.white)
                })
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(AppColors.primary)
                .cornerRadius(24)
                
            }
            .frame(width: 300, height: 300)
            .padding(.horizontal, 20)
            .foregroundColor(Color(hex: "D9D9D9"))
            
            Spacer()
                .frame(height: 20)
            
            
        }
        .background(Color(hex: "ffffff"))
        .overlay(
            RoundedCornersShape(corners: [.topLeft, .topRight], radius: 10)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [ AppColors.primary, Color.white]),
                                   startPoint: .top,
                                   endPoint: .bottom),
                    lineWidth: 2 // Width of the border
                )
            
        )
        .clipShape( RoundedCornersShape(corners: [.topLeft, .topRight], radius: 10))
        .shadow(color: Color.gray.opacity(0.2), radius: 12, x: 0, y: 0)
    }
    
    func openSettings() {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }

}

#Preview {
    EnableKeyboardView()
}
