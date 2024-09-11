import SwiftUI

@main
struct NaijaGuruApp: App {
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
