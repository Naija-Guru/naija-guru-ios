import Foundation
import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    private init(){}

    func startMonitoring(callback: @escaping (Bool) -> Void) {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
                // The device is connected to the internet
                callback(true)
            } else {
                print("No connection.")
                // The device is not connected to the internet
                callback(false)
            }
            
            print("Is it via WiFi? \(path.isExpensive)")
        }

        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
