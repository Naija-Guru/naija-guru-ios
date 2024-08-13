//
//  HomeView.swift
//  naijakeyboard
//
//  Created by Hyebreed on 11/08/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        VStack{
            ZStack{
                Image("nb_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 38, height: 38)
                
            }
            .frame(width: 66.7, height: 66.7)
            .background(AppColors.primaryColor)
            .cornerRadius(18)
            
            //
            Spacer()
                .frame(height: 30)
            
            Text("Welcome to Naija Keyboard")
                .font(.system(size: 26, weight: Font.Weight.semibold))
                .foregroundColor(AppColors.title)
            
            Spacer()
                .frame(height: 8)
            
            
            Text("Get your Naija Pidgin grammar on point...")
                .font(.system(size: 18, weight: Font.Weight.regular))
                .foregroundColor(AppColors.headerSubtitle)
            
            Spacer()
                .frame(height: 48)
            
            VStack {
                Text("Enable the keyboard")
                    .font(.system(size:16, weight: Font.Weight.semibold))
                    .foregroundColor(AppColors.title)
                    .padding(.horizontal, 10)
                
                Spacer()
                    .frame(height: 8)
                
                
                Text("The necessary permissions to run this app.")
                    .font(.system(size: 14, weight: Font.Weight.regular))
                    .foregroundColor(AppColors.headerSubtitle)
                    .padding(.horizontal, 10)
                
                VStack{
                    
                }//(cornerRadius: 10)
                    .frame(width: 300, height: 300)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color(hex: "D9D9D9"))
            }
            
            .padding(.horizontal, AppDimensions.pageMargin)
            .padding(.vertical, AppDimensions.pageMargin)
            .background(Color(hex: "ffffff"))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    
                    .stroke(
                        LinearGradient(gradient: Gradient(colors: [ Color.green, Color.white]),
                                       startPoint: .top,
                                       endPoint: .bottom),
                        lineWidth: 4 // Width of the border
                    ).clipShape(
                        RoundedCornersShape(corners: [.topLeft, .topRight], radius: 10)
                    )
                    
                    
                    
//                    .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
//                    .padding(.horizontal, 20)
            )
            .shadow(color: Color.black, radius: 10, x: 0, y: 0)
            .cornerRadius(10)
            
        }.padding(.horizontal, AppDimensions.pageMargin)
    }
}

#Preview {
    HomeView()
}

struct RoundedCornersShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
