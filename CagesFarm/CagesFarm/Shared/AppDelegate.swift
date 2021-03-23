//
//  AppDelegate.swift
//  CagesFarm
//
//  Created by Gilberto Magno on 3/8/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MenuViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

