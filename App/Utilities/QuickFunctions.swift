import Foundation
import UIKit

func isValidURL(_ urlString: String) -> Bool {
    if let url = URL(string: urlString) {
        return UIApplication.shared.canOpenURL(url)
    }
    return false
}
