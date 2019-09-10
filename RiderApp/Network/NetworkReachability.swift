//
//  NetworkReachability.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/6/19.
//

import Foundation

class NetworkReachability {
    
    private static var instance = NetworkReachability()
    public static func shared() -> NetworkReachability {
        return NetworkReachability.instance
    }

    private init() {
        if let reachability = AppDelegate.sharedAppDelegate()?.reachability {
            NotificationCenter.default.addObserver( self,
                                                    selector: #selector( reachabilityChanged ),
                                                    name: .reachabilityChanged,
                                                    object: reachability )
        }
    }
    
    @objc func reachabilityChanged( notification: NSNotification ) {
        guard let _ = notification.object as? Reachability else {
            return
        }
    }
}

extension NetworkReachability: ReachabilityProtocol {
    
    func isInternetAvailable() -> Bool {
        return Reachability.isConnectedToNetwork()
    }
}
