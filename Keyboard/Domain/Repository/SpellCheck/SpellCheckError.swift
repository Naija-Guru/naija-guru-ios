import Foundation

enum SpellCheckError: Error {
    case networkFailure
    case unknown(String)
}
