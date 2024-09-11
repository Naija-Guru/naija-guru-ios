import Foundation

class NavigationViewModel : ObservableObject {
    let openSettings : () -> Void
    
    init(openSettings: @escaping () -> Void) {
        self.openSettings = openSettings
    }
    
    @Published var showNaijakeyboard = false
    
    func toggleNaijaKeyboard(){
        showNaijakeyboard = !showNaijakeyboard
    }
}
