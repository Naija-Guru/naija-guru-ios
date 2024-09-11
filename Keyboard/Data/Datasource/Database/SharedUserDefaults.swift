import Foundation

class SharedUserDefaults {
    static func getUserDefaults() -> UserDefaults? {
        return UserDefaults(suiteName: "group.naijakeyboard")
    }
}
