//
//  SessionManager.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 11/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import Foundation
import os.log
import JWTDecode

class SessionManager: NSObject {
    
    static let shared = SessionManager(identifier: "session", accessGroup: nil)
    
    private let log = OSLog(subsystem: "PeixePay", category: "UserCredentialStorage")
    
    private let keychainItem: Keychain
    private let defaults = UserDefaults.standard
    
    init(identifier: String, accessGroup: String?) {
        self.keychainItem = Keychain(service: identifier, groupIdentifier: accessGroup)
    }
    
    public var authToken: String? {
        get {
            do {
                guard let data = try keychainItem.get(Keys.authTokenKey) else { return nil }
                return String(data: data, encoding: .utf8)
            } catch {
                os_log("Error retrieving access token: %{public}@", log: self.log, type: .error, String(describing: error))

                return nil
            }
        }
        set {
            if let token = newValue {
                do {
                    try keychainItem.set(value: Data(token.utf8), identifier: Keys.authTokenKey)
                    guard let token = authToken else { return }
                    profileId = try decode(jwt: token).body["profileId"] as? String
                } catch {
                    os_log("Error saving access token: %{public}@", log: self.log, type: .error, String(describing: error))
                }
            } else {
                deleteAuthToken()
            }
        }
    }
    
    public var refreshToken: String? {
        get {
            do {
                guard let data = try keychainItem.get(Keys.refreshTokenKey) else { return nil }

                return String(data: data, encoding: .utf8)
            } catch {
                os_log("Error retrieving access token: %{public}@", log: self.log, type: .error, String(describing: error))

                return nil
            }
        }
        set {
            if let token = newValue {
                do {
                    try keychainItem.set(value: Data(token.utf8), identifier: Keys.refreshTokenKey)
                } catch {
                    os_log("Error saving access token: %{public}@", log: self.log, type: .error, String(describing: error))
                }
            } else {
                deleteAuthToken()
            }
        }
    }
    
    public var profileId: String? {
        get {
            do {
                guard let data = try keychainItem.get(Keys.profileIDKey) else { return nil }
                return String(data: data, encoding: .utf8)
            } catch {
                os_log("Error saving access token: %{public}@", log: self.log, type: .error, String(describing: error))
                return nil
            }
        }
        set {
            if let id = newValue {
                do {
                    try keychainItem.set(value: Data(id.utf8), identifier: Keys.profileIDKey)
                } catch {
                    os_log("Error saving access token: %{public}@", log: self.log, type: .error, String(describing: error))
                }
            } else {
                deleteProfileID()
            }
        }
    }
    
    public func deleteAuthToken() {
        do {
            try keychainItem.delete(Keys.authTokenKey)
        } catch {
            os_log("Failed to delete access token from keychain: %{public}@", log: self.log, type: .error, String(describing: error))
        }
    }
    
    public func deleteRefreshToken() {
        do {
            try keychainItem.delete(Keys.refreshTokenKey)
        } catch {
            os_log("Failed to delete access token from keychain: %{public}@", log: self.log, type: .error, String(describing: error))
        }
    }
    
    public func deleteProfileID() {
        do {
            try keychainItem.delete(Keys.profileIDKey)
        } catch {
            os_log("Failed to delete access token from keychain: %{public}@", log: self.log, type: .error, String(describing: error))
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
        static let profileIDKey = "ProfileId"
    }
}

struct SessionModel {
    let acessToken: String
    let refreshToken: String
}

extension SessionManager {
    
    func getAccount() -> AccountInfo? {
        guard let cpf = defaults.value(forKey: Defaultskeys.cpfKey) as? String,
            let name = defaults.value(forKey: Defaultskeys.profileNamekey) as? String else { return nil }
        let accountInfo = AccountInfo(name: name, cpf: cpf)
        return accountInfo
    }
    
    func saveAccount(profile: ProfileParsable) {
        defaults.setValue(profile.cpf, forKey: Defaultskeys.cpfKey)
        defaults.setValue(profile.name, forKey: Defaultskeys.profileNamekey)
    }
    
    struct Defaultskeys {
        static let cpfKey = "cpfKey"
        static let profileNamekey = "profileNameKey"
    }
}
