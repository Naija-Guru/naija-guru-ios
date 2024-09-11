import Foundation

protocol SpellCheckRepo {
    
    func getCorrections(text: String) async -> Result<[Match], SpellCheckError>
    
    func addIgnoreRule(_ ignoreRule : IgnoreRule) async -> Result<Bool, SpellCheckError>
    
    func getAllIgnoreRules() async -> Result<[IgnoreRule], SpellCheckError>
    
}
