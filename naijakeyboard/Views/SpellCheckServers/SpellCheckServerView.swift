//
//  SpellCheckServerView.swift
//  naijakeyboard
//
//  Created by Emmanuel Idaresit on 19/08/2024.
//

import SwiftUI

struct SpellCheckServerView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var settingsVM : SettingsViewModel
    
    @State var primaryURL : String = ""
    
    @State var secondaryURL : String = ""
    
    var body: some View {
        VStack(alignment: .leading){
            Divider()
            VStack(alignment: .leading){
                
                Spacer()
                    .frame(height: 32)
                
                Text("Servers")
                    .font(.custom("Poppins-SemiBold", size: 14))
                    .foregroundColor(Color(hex: "747474"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                    .frame(height: 20)
                
                Text("Primary Server")
                    .font(.custom("CabinetGroteskVariable-Bold_Bold", size: 18))
                    .foregroundColor(Color(hex: "171A19"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ServerTextField(url: $primaryURL)
                
                Spacer()
                    .frame(height: 32)
                
                Text("Secondary Server")
                    .font(.custom("CabinetGroteskVariable-Bold_Bold", size: 18))
                    .foregroundColor(Color(hex: "171A19"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ServerTextField(url: $secondaryURL)
                
                
                Spacer()
                
                Button(action: {
                    if(primaryURL == settingsVM.primaryServer &&
                       secondaryURL == settingsVM.secondaryServer) {return}
                    
                    if isValidURL(primaryURL) && isValidURL(secondaryURL) {
                        settingsVM.saveServers(primaryURL: primaryURL, secondaryURL: secondaryURL)
                        dismiss()// navigate back
                    }
                    
                }
                       , label: {
                    Text("Save")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(primaryURL == settingsVM.primaryServer &&
                                    secondaryURL == settingsVM.secondaryServer ? .gray : AppColors.primary)
                        .clipShape(RoundedCornersShape(corners: .allCorners, radius: 10))
                })
                                   
                Spacer()
                    .frame(height: 10)
            }.padding(.horizontal, AppDimensions.pageMargin)
        }.navigationTitle("Spell Check Servers")
            .onAppear {
                primaryURL = settingsVM.primaryServer
                secondaryURL = settingsVM.secondaryServer
            }
    }
}

#Preview {
    SpellCheckServerView()
        .environmentObject(SettingsViewModel())
}
