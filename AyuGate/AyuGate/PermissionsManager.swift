//
//  PermissionsManager.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 24/09/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class PermissionsManager: NSObject {
    
    private let center = UNUserNotificationCenter.current()
    
    static var shared = PermissionsManager()
    
    private override init() {
        super.init()
    }
    
    func requestNotification() {
         center.requestAuthorization(options: [.alert, .sound, .badge, .provisional]) { granted, error in
            if let error = error {
                 // Handle the error here.
            }
            self.registerForRemoteNotification()
         }
    }
    
    func registerForRemoteNotification() {
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
}
