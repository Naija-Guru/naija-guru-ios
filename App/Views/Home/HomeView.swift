import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var homeVM : HomeViewModel
    
    var body: some View {
        
        VStack{
                Image("naija_guru_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 77, height: 92)

            Spacer()
                .frame(height: 30)
            
            Text("Welcome to Naija Keyboard")
                .font(.custom("CabinetGroteskVariable-Bold_Bold", size: 26))
                .foregroundColor(AppColors.primary)
            
            Spacer()
                .frame(height: 8)
            
            
            Text("Get your Naija Pidgin grammar on point...")
                .font(.custom("CabinetGroteskVariable-Bold_Regular", size: 18))
                .foregroundColor(AppColors.headerSubtitle)
            
            Spacer()
                .frame(height: 48)
            
            EnableKeyboardView(isEnabled: homeVM.isKeyboardEnabled)
            
            Spacer()
                .frame(height: 40)
            
            NavigationLink(destination:  SettingsView(), label: {
                HStack(){
                    ZStack{
                        Image(systemName: "gear")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 28, height: 28)
                            .foregroundColor(AppColors.primary)
                        
                    }
                    .frame(width: 44, height: 44)
                    .background(AppColors.primaryLight)
                    .cornerRadius(20)
                    
                    Text("Settings")
                        .font(.custom("CabinetGroteskVariable-Bold_Medium", size: 18))
                        .foregroundColor(Color(hex:"292C32"))
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 75)
                .background(.white)
                .clipShape( RoundedCornersShape(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10))
                .shadow(color: Color.gray.opacity(0.2), radius: 12, x: 0, y: 0)
            })
            
        }.padding(.horizontal, AppDimensions.pageMargin)
            .onAppear{
                homeVM.fetchIsKeyboardEnabled()
            }
          
    }//view
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}

