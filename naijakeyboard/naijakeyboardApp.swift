//
//  naijakeyboardApp.swift
//  naijakeyboard
//
//  Created by Emmanuel Idaresit on 11/08/2024.
//

import SwiftUI

@main
struct naijakeyboardApp: App {
    @StateObject private var settingsViewModel = SettingsViewModel()
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
            }.tint(AppColors.primary)
                .environmentObject(settingsViewModel)
                .environmentObject(homeViewModel)
        }
    }
    
  
    
}
