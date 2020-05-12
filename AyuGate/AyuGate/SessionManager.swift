//
//  SessionManager.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 11/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import Foundation

class SessionManager: NSObject {
    
    static let shared = SessionManager()
    
    let defaults = UserDefaults.standard
    
    var authToken: String? {
        get {
            return defaults.string(forKey: Keys.authTokenKey)
        }
        set {
            defaults.set(newValue, forKey: Keys.authTokenKey)
        }
    }
    
    var refreshToken: String? {
        get {
            return defaults.string(forKey: Keys.authTokenKey)
        }
        set {
            defaults.set(newValue, forKey: Keys.refreshTokenKey)
        }
    }
    
    var isUserLoged: Bool {
        return authToken != nil
    }
    
}

extension SessionManager {
    struct Keys {
        static let authTokenKey = "UserAuthTokenKey"
        static let refreshTokenKey = "UserRefreshTokenKey"
    }
}

struct SessionModel {
    let acessToke: String
    let refreshToken: String
}
