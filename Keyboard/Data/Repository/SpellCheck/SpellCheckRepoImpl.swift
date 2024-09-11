import Foundation

class SpellCheckRepoImpl : SpellCheckRepo {
    
    let spellCheckApi : SpellCheckApi
    
    init(_ spellCheckApi: SpellCheckApi) {
        self.spellCheckApi = spellCheckApi
    }
    
    func getCorrections(text: String) async -> Result<[Match], SpellCheckError> {
        do{
            let result = try await spellCheckApi.spellCheck(text: text, baseURL: ApiClient.shared.primaryURL)
            return .success(result)
        }catch {
            // if primary url does not work
            // fall to secondary url
            do{
                let result = try await spellCheckApi.spellCheck(text: text, baseURL: ApiClient.shared.secondaryURL)
                return .success(result)
            }catch {
                print(error)
                return .failure(SpellCheckError.unknown("\(error)"))
            }
        }
    }
    
    func addIgnoreRule(_ ignoreRule: IgnoreRule) async -> Result<Bool, SpellCheckError> {
        if let userDefaults = SharedUserDefaults.getUserDefaults() {
            let result = await getAllIgnoreRules()
            do{
                var ignoreList = try result.get()
                if(!ignoreList.contains(where: { rule in
                    return rule.id == ignoreRule.id
                })){
                    ignoreList.append(ignoreRule)
                    
                    userDefaults.setValue(ignoreList.map({ irule in irule.toDictionary()}), forKey: IgnoreRule.getKey())
                   
                }
                return .success(true)
            }catch {
                print(error)
                return .failure(SpellCheckError.unknown(String(describing: error)))
            }
        }
        return .failure(SpellCheckError.unknown("sharedGroup not available (addIgnoreRule)"))
    }
    
    
    func getAllIgnoreRules() async -> Result<[IgnoreRule], SpellCheckError> {
        
        if let userDefaults = SharedUserDefaults.getUserDefaults() {
            if let result  = userDefaults.array(forKey: IgnoreRule.getKey()) as! [[String : Any]]?{
                let ignoreAllList = result.map { d in
                    return IgnoreRule.fromDictionary(d)
                }
                return .success(ignoreAllList)
            }
            return .success([] as! [IgnoreRule])
            
        }
        return .failure(SpellCheckError.unknown("sharedGroup not available (getAllIgnoreRules)"))
    }
    
}
