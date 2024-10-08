import Foundation

// MARK: - SpellCheckResponse
struct SpellCheckResponse: Codable {
    let software: Software
    let warnings: Warnings
    let language: Language
    let matches: [Match]
    let sentenceRanges: [[Int]]
    let extendedSentenceRanges: [ExtendedSentenceRange]
}

// MARK: - ExtendedSentenceRange
struct ExtendedSentenceRange: Codable {
    let from, to: Int
    let detectedLanguages: [DetectedLanguageElement]
}

// MARK: - DetectedLanguageElement
struct DetectedLanguageElement: Codable {
    let language: String
    let rate: Int
}

// MARK: - Language
struct Language: Codable {
    let name, code: String
    let detectedLanguage: LanguageDetectedLanguage
}

// MARK: - LanguageDetectedLanguage
struct LanguageDetectedLanguage: Codable {
    let name, code: String
    let confidence: Double
    let source: String
}

// MARK: - Match
struct Match: Codable, Hashable {
    
    let message, shortMessage: String
    let replacements: [Replacement]
    let offset, length: Int
    let context: Context
    let sentence: String
    let type: TypeClass
    let rule: Rule
    let ignoreForIncompleteSentence: Bool
    let contextForSureMatch: Int
    
    static func == (lhs: Match, rhs: Match) -> Bool {
        return lhs.message == rhs.message && lhs.replacements == rhs.replacements && lhs.offset == rhs.offset && lhs.length == rhs.length && lhs.context == rhs.context && lhs.sentence == rhs.sentence && lhs.rule == rhs.rule && lhs.ignoreForIncompleteSentence == rhs.ignoreForIncompleteSentence && lhs.contextForSureMatch == rhs.contextForSureMatch
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(message)
        hasher.combine(shortMessage)
        hasher.combine(offset)
        hasher.combine(length)
        hasher.combine(context)
        hasher.combine(sentence)
        hasher.combine(type)
        hasher.combine(rule)
        hasher.combine(ignoreForIncompleteSentence)
        hasher.combine(contextForSureMatch)
        
    }
}

// MARK: - Context
struct Context: Codable, Hashable {
    let text: String
    let offset, length: Int
    
    static func == (lhs: Context, rhs: Context) -> Bool {
        return lhs.text == rhs.text && lhs.offset == rhs.offset && lhs.length == rhs.length
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(text)
        hasher.combine(offset)
        hasher.combine(length)
        
        
    }
}

// MARK: - Replacement
struct Replacement: Codable, Equatable {
    let value: String
    
    static func == (lhs: Replacement, rhs: Replacement) -> Bool {
        return lhs.value == rhs.value
    }
}

// MARK: - Rule
struct Rule: Codable, Hashable {
    let id,  description: String
    let subID, sourceFile : String?
    let issueType: String
    let category: Category
    
    enum CodingKeys: String, CodingKey {
        case id
        case subID = "subId"
        case sourceFile, description, issueType, category
    }
    
    static func == (lhs: Rule, rhs: Rule) -> Bool {
        return lhs.id == rhs.id && lhs.subID == rhs.subID && lhs.sourceFile == rhs.sourceFile && lhs.description == rhs.description && lhs.issueType == rhs.issueType && lhs.category == rhs.category
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(subID)
        hasher.combine(sourceFile)
        hasher.combine(description)
        hasher.combine(issueType)
        hasher.combine(category)
        
    }
    
}

// MARK: - Category
struct Category: Codable, Hashable {
    let id, name: String
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}

// MARK: - TypeClass
struct TypeClass: Codable, Hashable {
    let typeName: String
    
    static func == (lhs: TypeClass, rhs: TypeClass) -> Bool {
        return lhs.typeName == rhs.typeName
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(typeName)
    }
}

// MARK: - Software
struct Software: Codable {
    let name, version, buildDate: String
    let apiVersion: Int
    let premium: Bool
    let premiumHint, status: String
}

// MARK: - Warnings
struct Warnings: Codable {
    let incompleteResults: Bool
}
