//
//  naijakeyboardApp.swift
//  naijakeyboard
//
//  Created by Hyebreed on 11/08/2024.
//

import SwiftUI

@main
struct naijakeyboardApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
            }.tint(AppColors.primary)
        }
    }
    
}
