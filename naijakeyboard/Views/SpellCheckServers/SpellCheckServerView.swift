//
//  SpellCheckServerView.swift
//  naijakeyboard
//
//  Created by Hyebreed on 19/08/2024.
//

import SwiftUI

struct SpellCheckServerView: View {
    var body: some View {
        VStack(alignment: .leading){
            Divider()
            VStack(alignment: .leading){
                
                Spacer()
                    .frame(height: 32)
                
                Text("Servers")
                    .font(.system(size: 14, weight: Font.Weight.semibold))
                    .foregroundColor(Color(hex: "747474"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                    .frame(height: 20)
                
               
                
                ServerListItemView(serverName: "Server 1", serverDomain: "spellchecker-1.nl.naija.guru", isConnected: true) {
                    
                }
                
                Spacer()
                    .frame(height: 10)
                
                ServerListItemView(serverName: "Server 2", serverDomain: "spellchecker-1.de.naija.guru", isConnected: false) {
                    
                }
                
                Spacer()
            }.padding(.horizontal, AppDimensions.pageMargin)
        }.navigationTitle("Spell Check Servers")
    }
}

#Preview {
    SpellCheckServerView()
}
