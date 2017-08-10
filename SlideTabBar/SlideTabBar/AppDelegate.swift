//
//  AppDelegate.swift
//  SlideTabBar
//
//  Created by kaideyi on 2017/2/19.
//  Copyright © 2017年 kaideyi.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let controller = ViewController()
        let navigation = UINavigationController(rootViewController: controller)
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        return true
    }
}

