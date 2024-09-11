import Foundation

class ServiceLocator {
    static let shared = ServiceLocator()

    private var services: [String: AnyObject] = [:]

    private init() {}
    
    func register<T>(_ service: T, for type: T.Type) {
            let key = String(describing: type)
            services[key] = service as AnyObject
        }
    
    func resolve<T>(_ type: T.Type) -> T? {
           let key = String(describing: type)
           return services[key] as? T
       }
}
