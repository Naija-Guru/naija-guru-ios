import SwiftUI

struct SpellCheckStateDescriptionView: View {
    
    let text : String
    let image : String
    
    var body: some View {
        
        VStack {
            Text(text)
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(.black)
            
            Spacer()
                .frame(height: 16)
            
            Image(image)
                .resizable()
                .frame(width: 108, height: 120) 
        }
    }
}

#Preview {
    SpellCheckStateDescriptionView(text: "Good job!", image: "wifi_off")
}
