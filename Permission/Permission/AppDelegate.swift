//
//  AppDelegate.swift
//  Permission
//
//  Created by mac on 17/2/24.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window?.frame = UIScreen.main.bounds
        window?.backgroundColor = .white
        
        let controller = ViewController(nibName: "ViewController", bundle: nil)
        let navigation = UINavigationController(rootViewController: controller)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        return true
    }
}

