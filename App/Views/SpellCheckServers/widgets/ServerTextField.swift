import SwiftUI

struct ServerTextField: View {
    
    let url : Binding<String>
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                HStack{
                    TextField("Server Url", text: url)
                    Spacer()
                        .frame(width: 10)
                    Image("edit_pencil")
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 16)
            }
            .overlay(
                RoundedCornersShape(corners: .allCorners, radius: 12)
                    .fill(.clear)
                    .stroke(isValidURL(url.wrappedValue) ? Color(hex: "CCCCCC") : .red, style: .init(lineWidth: 1.0))
            )
            
            if !isValidURL(url.wrappedValue) {
                Text("Please input a correct URL")
                    .foregroundColor(.red)
                    .font(.system(size: 12))
            }
        }
    }
}

#Preview {
    ServerTextField(url: Binding<String> {"https://som.com"} set: { value in})
}
