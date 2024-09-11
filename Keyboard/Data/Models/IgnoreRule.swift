import Foundation

struct IgnoreRule {
    let id : String
    let ruleType : IgnoreRuleType
    let displayTitle : String
    let dateTime : Date
    
    func toDictionary() -> [String : Any] {
        return [
            "id" : id,
            "ruleType" : ruleType.toString(),
            "displayTitle" : displayTitle,
            "dateTime" : Int64(dateTime.timeIntervalSince1970 * 1000)
        ]
    }
    
    static func fromDictionary(_ dictionary : [String : Any]) -> IgnoreRule {
        return IgnoreRule(
            id: dictionary["id"] as! String,
            ruleType: IgnoreRuleType.fromString(dictionary["ruleType"] as! String),
            displayTitle: dictionary["displayTitle"] as! String,
            dateTime: Date(timeIntervalSince1970: Double((dictionary["dateTime"] as? Int64 ?? 1704121445123)) / 1000)
        )
    }
    
    static func getKey() -> String {
        return "ignoreAllList"
    }
    
    
}

enum IgnoreRuleType {
    case rule
    case category
    
    func toString() -> String {
        return self == .rule ? "rule" : "category"
    }
    
    static func fromString(_ val: String) -> IgnoreRuleType{
        switch val {
        case "rule" : return .rule
        case "category" : return .category
        default:
            return .rule
        }
    }

}
