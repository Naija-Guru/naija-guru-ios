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
//            ContentView()
            NavigationStack{
                HomeView()
            }.tint(AppColors.primary)
        }
    }
    
//    class AppDelegate: NSObject, UIApplicationDelegate {
//        func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//            if url.scheme == "naijakeyboardapp" {
//                // Handle the URL and navigate to the appropriate page
//                // For example, check the path and navigate accordingly
//                if url.host == "openSettings" {
//                    // Navigate to the specific page
//                    NotificationCenter.default.post(name: NSNotification.Name("NavigateToSettings"), object: nil)
//                }
//            }
//            return true
//        }
//    }
}
