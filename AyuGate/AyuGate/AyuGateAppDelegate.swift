//
//  AppDelegate.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 14/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

@UIApplicationMain
class AyuGateAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        prepareMainViewController()
        return true
    }

    func prepareMainViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)

        window?.rootViewController = AppFlow.shared.flow()
        window?.makeKeyAndVisible()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = String(pushToken: deviceToken)
        NSLog("Push token: \(token)")
        SessionManager.shared.pushToken = token
    }
}

