import SwiftUI
import WebKit

struct GifImage : UIViewRepresentable {
    private let name : String
    init(_ name: String) {
        self.name = name
    }
    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
         let url = Bundle.main.url(forResource: name, withExtension: "gif")
        let data = try! Data(contentsOf: url!)
        
        webview.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url!.deletingLastPathComponent())
        return webview
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.reload()
    }
}

#Preview {
    GifImage("instructions_gif")
}
