import SwiftUI

struct MainView: View {
   
    @EnvironmentObject private var navigationVM : NavigationViewModel
    @EnvironmentObject private var spellCheckerVM : SpellCheckerViewModel

    init(){
        if let userDefaults = SharedUserDefaults.getUserDefaults() {
            userDefaults.setValue(true, forKey: "isKeyboardEnabled")
        }
    }
    
    var body: some View {
        
        if(navigationVM.showNaijakeyboard){
            NaijaKeyboard()
            .frame(height: 252)
            .environmentObject(navigationVM)
            .environmentObject(spellCheckerVM)
        }else{
            
            ASCIIKeyboard()
            .frame(height: 252)
            .environmentObject(navigationVM)
            .environmentObject(spellCheckerVM)
        }
        
    }
}

#Preview {
    MainView()
}
