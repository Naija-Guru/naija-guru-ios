import SwiftUI

struct IgnoreRulesView: View {
    
    @EnvironmentObject private var settingsVM : SettingsViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            Divider()
            VStack(alignment: .leading){
                
                Spacer()
                    .frame(height: 32)
                
                Text("See all the rules you have ignored ...")
                    .font(.custom("Poppins-SemiBold", size: 14))
                    .foregroundColor(Color(hex: "747474"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                    .frame(height: 20)
                
                if(settingsVM.ignoreRules.isEmpty){
                    VStack(alignment: .center){
                        Spacer()
                        Image("empty_boards")
                        Text("You have not ignored any rule yet")
                            .font(.custom("Poppins-Bold", size: 24))
                            .foregroundColor(Color(hex: "171A19"))
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                }else{
                    ForEach(0..<settingsVM.ignoreRules.count, id: \.self) { index in
                        IgnoreRuleListItem(ignoreRule: settingsVM.ignoreRules[index]) {
                            settingsVM.removeIgnoreRule(ignoreRule: settingsVM.ignoreRules[index])
                        }
                        .padding(.vertical, 10)
                    }
                }
                          
                Spacer()
                    
            }.padding(.horizontal, AppDimensions.pageMargin)
        }.navigationTitle("Ignore Rules")
        .onAppear{
                settingsVM.loadPreferences() // comment this when viewing the preview to switch between empty and field list
            }

    }
}

#Preview {
    IgnoreRulesView()
        .environmentObject(SettingsViewModel(true))
    
}
