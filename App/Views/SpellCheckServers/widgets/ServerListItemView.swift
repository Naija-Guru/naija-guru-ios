import SwiftUI

struct ServerListItemView: View {
    var serverName : String
    var serverDomain : String
    var isConnected : Bool
    var connect : () -> Void
    
    var body: some View {
        
        ZStack{
            
            VStack{
            } .frame(maxWidth: .infinity)
                .frame(height: 220)
                .overlay(RoundedCornersShape(corners: [.allCorners], radius: 24)
                    .stroke( AppColors.primary, lineWidth: 1)
                    .fill(
                        RadialGradient(gradient: 
                            Gradient(colors: [
                                Color(hex: "FAFCFC"),
                                Color(hex: "E1FAF4"),
                                Color(hex: "B4F5E5")]),
                                         center: .bottomTrailing,
                                         startRadius: 180,
                                         endRadius: 0
                     )
                    )
                )

            VStack(alignment: .leading){
                
                Spacer()
                    .frame(height: 24)
                
                ZStack{
                    Image(uiImage: UIImage(named: "server")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(AppColors.primary)
                }
                .frame(width: 40, height: 40)
                .background(AppColors.secondaryColor)
                .clipShape(Circle())
                .padding(.horizontal, 24)
                
                Spacer()
                    .frame(height: 16)
                
                Text(serverName)
                    .font(.custom("CabinetGroteskVariable-Bold_Bold", size: 20))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                
                Spacer()
                    .frame(height: 8)
                
                Text(serverDomain)
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundColor(AppColors.serverItemSubtitle)
                    .padding(.horizontal, 24)
                
                Spacer()
                    .frame(height: 16)
                
                Button(action: {
                    connect()
                }, label: {
                    Text(isConnected ? "Connected" : "Connect")
                        .font(.custom("Poppins-Bold", size: 14))
                        .foregroundColor(isConnected ? .white : AppColors.primary)
                })
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(isConnected ? AppColors.primary : .clear)
                .cornerRadius(24)
                .overlay(RoundedCornersShape(corners: [.allCorners], radius: 24)
                    .stroke(isConnected ? .clear : AppColors.primary , lineWidth: 1))
                .padding(.horizontal, 24)
                
                Spacer()
                    .frame(height: 24)
            }
        }
    }
}

#Preview {
    ServerListItemView(serverName: "Server 1", serverDomain: "spellchecker-1.nl.naija.guru", isConnected: false){
        
    }
}
