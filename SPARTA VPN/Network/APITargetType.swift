//
//  APITargetType.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import Foundation
import Moya

protocol APITargetType: TargetType {
   
    var requestHeaders: [URLRequest.Header: String]? { get }
}

// MARK: - Own trait

extension APITargetType {
  
    var requestHeaders: [URLRequest.Header: String]? {
        return nil
    }
}

// MARK: - TargetType trait

extension APITargetType {
    
    static var baseURL: URL {
        return AppConfiguration.environment.baseURL
    }
    
    var path: String {
        return path
    }

    var baseURL: URL {
        return Self.baseURL
    }

    var headers: [String: String]? {
        return requestHeaders?.reduce(into: [String: String]()) { result, pair in
            result[pair.key.rawValue] = pair.value
        }
    }
    
    static var baseParameters: [String: Any] {
        return [:]
    }
}

// MARK: - Bearer header plugin support
extension APITargetType {
    func makeBearerTokenType(from token: String) -> AuthorizationType {
        return .custom(token)
    }
}
