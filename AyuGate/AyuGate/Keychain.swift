//
//  Keychain.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 12/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import Foundation
import Security
import os.log

public protocol DataSaver {
    func set(value: Data, identifier: String) throws
    func get(_ identifier: String) throws -> Data?
    func delete(_ identifier: String) throws
    func deleteAll() throws
}

public final class Keychain: DataSaver {

    private let log = OSLog(subsystem: "LoginCore", category: "Keychain")

    let service: String
    let groupIdentifier: String?

    public init(service: String, groupIdentifier: String? = nil) {
        self.service = service
        self.groupIdentifier = groupIdentifier
    }

    private func sanitizeAttributesIfNeeded(_ attrs: inout [CFString: Any]) {
        // Keychain access groups don't work in the Simulator
        #if targetEnvironment(simulator)
        attrs.removeValue(forKey: kSecAttrAccessGroup)
        #endif
    }

    private func itemExists(with identifier: String) throws -> Bool {
        var attrs: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: identifier,
            kSecAttrService: service,
            kSecReturnData: false
        ]

        if let group = groupIdentifier { attrs[kSecAttrAccessGroup] = group }

        sanitizeAttributesIfNeeded(&attrs)

        let status = SecItemCopyMatching(attrs as NSDictionary, nil)

        if status == errSecSuccess {
            return true
        } else if status == errSecItemNotFound {
            return false
        } else {
            throw Errors.keychainError
        }
    }

    private func add(value: Data, identifier: String) throws {
        var attrs: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: identifier,
            kSecAttrService: service,
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
            kSecValueData: value
        ]

        if let group = groupIdentifier { attrs[kSecAttrAccessGroup] = group }

        sanitizeAttributesIfNeeded(&attrs)

        let status = SecItemAdd(attrs as NSDictionary, nil)
        
        guard status == errSecSuccess else {
            logStatus(status: status)
            throw Errors.keychainError
        }
    }

    private func update(value: Data, identifier: String) throws {
        var attrs: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: identifier,
            kSecAttrService: service
        ]

        if let group = groupIdentifier { attrs[kSecAttrAccessGroup] = group }

        sanitizeAttributesIfNeeded(&attrs)

        let status = SecItemUpdate(attrs as NSDictionary, [
                kSecValueData: value,
        ] as NSDictionary)

        guard status == errSecSuccess else {
            logStatus(status: status)
            throw Errors.keychainError
        }
    }

    public func set(value: Data, identifier: String) throws {
        if try itemExists(with: identifier) {
            try update(value: value, identifier: identifier)
        } else {
            try add(value: value, identifier: identifier)
        }
    }

    public func get(_ identifier: String) throws -> Data? {
        var result: AnyObject?

        var attrs: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: identifier,
            kSecAttrService: service,
            kSecReturnData: true
        ]

        if let group = groupIdentifier { attrs[kSecAttrAccessGroup] = group }

        sanitizeAttributesIfNeeded(&attrs)

        let status = SecItemCopyMatching(attrs as NSDictionary, &result)

        if status == errSecSuccess {
            return result as? Data
        } else if status == errSecItemNotFound {
            return nil
        } else {
            logStatus(status: status)
            throw Errors.keychainError
        }
    }

    public func delete(_ identifier: String) throws {
        var attrs: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: identifier,
            kSecAttrService: service
        ]

        if let group = groupIdentifier { attrs[kSecAttrAccessGroup] = group }

        sanitizeAttributesIfNeeded(&attrs)

        let status = SecItemDelete(attrs as NSDictionary)

        guard status == errSecSuccess else {
            logStatus(status: status)
            throw Errors.keychainError
        }
    }

    public func deleteAll() throws {
        var attrs: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service
        ]

        if let group = groupIdentifier { attrs[kSecAttrAccessGroup] = group }

        sanitizeAttributesIfNeeded(&attrs)

        let status = SecItemDelete(attrs as NSDictionary)

        guard status == errSecSuccess else {
            logStatus(status: status)
            throw Errors.keychainError
        }
    }
    
    private func logStatus(status: OSStatus) {
        if #available(iOS 11.3, *) {
            let errorDescription: NSString? = SecCopyErrorMessageString(status, nil)
            os_log("Keychain error :\n%{public}@", log: log, type: .error, String(describing: errorDescription))
        }
    }

    enum Errors: Error {
        case keychainError
    }
}
