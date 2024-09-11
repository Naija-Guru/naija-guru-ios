import Foundation

enum Server : String, CaseIterable {
    case s1 = "spellchecker-1.nl.naija.guru"
    case s2 = "spellchecker-1.de.naija.guru"
    
    var serverName: String {
        switch self {
        case .s1: return "Server 1"
        case .s2: return "Server 2"
        }
    }
    
    var serverURL : String {
        switch self {
        case .s1: return "https://spellchecker-1.nl.naija.guru/"
        case .s2: return "https://spellchecker-1.de.naija.guru/"
        }
    }
    
    static func fromURL(_ val: String) -> Server{
        switch val {
        case "https://spellchecker-1.nl.naija.guru/" : return .s1
        case "https://spellchecker-1.de.naija.guru/" : return .s2
        default:
            return .s1
        }
    }
}
