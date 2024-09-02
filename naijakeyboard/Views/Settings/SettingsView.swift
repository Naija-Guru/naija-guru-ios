//
//  SettingsView.swift
//  naijakeyboard
//
//  Created by Emmanuel Idaresit on 11/08/2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        
        VStack(alignment: .leading){
            Divider()
            VStack(alignment: .leading){
                
                Spacer()
                    .frame(height: 32)
                
                Text("General")
                    .font(.custom("Poppins-SemiBold", size: 14))
                    .foregroundColor(Color(hex: "747474"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                    .frame(height: 20)
                
                SettingsListItem(image: "ignore_rules", title: "Ignore Rules", subTitle: "See the list of ruels you've ignored")
                
                Spacer()
                    .frame(height: 24)
                
                Divider()
                
                Spacer()
                    .frame(height: 24)
                NavigationLink(destination:  SpellCheckServerView(), label: {
                    SettingsListItem(image: "server", title: "Spell Check Servers", subTitle: "Change spell check servers")
                })
                
                Spacer()
                    .frame(height: 24)
                
                Divider()
                
                Spacer()
                    .frame(height: 24)
                
                Link(destination: URL(string: "https://community.naija.guru")!, label: {
                    SettingsListItem(image: "share_feedback", title: "Share Feedback", subTitle: "We'd love to hear from you")
                })
                
                Spacer()
            }
            .padding(.horizontal, AppDimensions.pageMargin)
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
