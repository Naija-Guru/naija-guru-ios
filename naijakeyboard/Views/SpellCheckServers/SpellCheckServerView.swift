//
//  SpellCheckServerView.swift
//  naijakeyboard
//
//  Created by Emmanuel Idaresit on 19/08/2024.
//

import SwiftUI

struct SpellCheckServerView: View {
    
    @EnvironmentObject private var settingsVM : SettingsViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            Divider()
            VStack(alignment: .leading){
                
                Spacer()
                    .frame(height: 32)
                
                Text("Servers")
                    .font(.custom("Poppins-SemiBold", size: 14))
//                    .font(.system(size: 14, weight: Font.Weight.semibold))
                    .foregroundColor(Color(hex: "747474"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                    .frame(height: 20)
                
                
                VStack(spacing: 10) {
                    ForEach(Server.allCases, id: \.rawValue){ server in
                        ServerListItemView(serverName: server.serverName, serverDomain: server.rawValue, isConnected: settingsVM.currentServer == server) {
                            settingsVM.connectServer(server: server)
                        }
                    }
                }
                
                Spacer()
            }.padding(.horizontal, AppDimensions.pageMargin)
        }.navigationTitle("Spell Check Servers")
    }
}

#Preview {
    SpellCheckServerView()
}
