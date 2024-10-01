//
//  KeychainService.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import Foundation
import KeychainSwift

protocol KeychainServiceType {
    var apiToken: String? { get set }
    var isAuthorized: Bool { get }
}

final class KeychainService: KeychainServiceType {
    
    static let `default` = KeychainService()
    
    private init() { }
    
    private lazy var keychain: KeychainSwift = {
        let keyPrefix = "gaxoshealth"
        let kc = KeychainSwift(keyPrefix: keyPrefix)
        kc.synchronizable = true
        return kc
    }()
    
    private enum Keys: String, CaseIterable {
        case apiToken
    }
    
    var isAuthorized: Bool {
        apiToken != nil
    }
    
    var apiToken: String? {
        get {
            return keychain.get(Keys.apiToken.rawValue)
        }
        set(newValue) {
            guard let value = newValue else {
                keychain.delete(Keys.apiToken.rawValue)
                return
            }
            keychain.set(value, forKey: Keys.apiToken.rawValue, withAccess: .accessibleWhenUnlockedThisDeviceOnly)
        }
    }
}
