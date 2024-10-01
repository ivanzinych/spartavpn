//
//  DIService.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import Foundation
import Swinject

// swiftlint:disable force_unwrapping
final class DIService {
    
    static let container = Container()
    
    private static func resolve<Service>(_ serviceType: Service.Type, name: String? = nil) -> Service {
        guard let service = container.resolve(serviceType, name: name) else {
            fatalError("\(serviceType)")
        }
        return service
    }
    
    static func start() {
        container.register(KeychainService.self) { _ in
            let service = KeychainService.default
            return service
        }.inObjectScope(.container)
        
        container.register(APIService.self) { r in
            return APIService(keychainService: r.resolve(KeychainService.self)!)
        }.inObjectScope(.container)
    }
}

// MARK: - View Models

extension DIService {
}

extension DIService {
    
    static var authKeychainService: KeychainService {
        return resolve(KeychainService.self)
    }
}

// MARK: - API Services

extension DIService {
    
    static var authAPIService: AuthAPIServiceType {
        return resolve(APIService.self)
    }
    
    static var userAPIService: UserAPIServiceType {
        return resolve(APIService.self)
    }
}
