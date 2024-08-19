//
//  SettingsView.swift
//  naijakeyboard
//
//  Created by Hyebreed on 11/08/2024.
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
                    .font(.system(size: 14, weight: Font.Weight.semibold))
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
                
                Divider()
                
                Spacer()
                    .frame(height: 24)
                
                SettingsListItem(image: "share_feedback", title: "share Feedback", subTitle: "We'd love to hear from you")
                
                Spacer()
            }
            .padding(.horizontal, AppDimensions.pageMargin)
        }
        .navigationTitle("Settings")
//        .frame(maxWidth: .infinity ,maxHeight: .infinity ).background(.yellow)
    }
}

#Preview {
    SettingsView()
}
