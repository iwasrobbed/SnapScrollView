//
//  AppDelegate.swift
//  SnapScrollView
//
//  Created by Rob Phillips on 6/19/17.
//  Copyright © 2017 ChefBrain Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        _setupRootView()
        
        return true
    }

}

// MARK: - Private Helpers

private extension AppDelegate {
    
    /// Sets up the root view on initial launch
    func _setupRootView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }

}

