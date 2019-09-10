//
//  AppDelegate.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/6/19.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var reachability: Reachability?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        initReachability()
        let router = DeliveryListRouter.make()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = router
        window?.makeKeyAndVisible()
        return true
    }

    func initReachability() {
        reachability = Reachability()
        do {
            try reachability?.startNotifier()
        } catch {
            print( "ERROR: Could not start reachability notifier.")
        }
    }

    class func sharedAppDelegate() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
}
