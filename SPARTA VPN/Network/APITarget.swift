//
//  APITarget.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import UIKit
import Moya

class APITarget: APITargetType {
    
    enum HeaderConstants {
        static let defaultRequestHeaders: [URLRequest.Header: String] = [.platform: "ios",
                                                                         .userAgent: "mobile",
                                                                         .accept: "application/json"]
    }
    
    let type: APITargetType
    private weak var apiService: APIService?
    
    init(type: APITargetType,
         apiService: APIService?) {
        self.type = type
        self.apiService = apiService
    }
    
    var baseURL: URL {
        return type.baseURL
    }
    
    var path: String {
        return type.path
    }
    
    var method: Moya.Method {
        return type.method
    }
    
    var task: Task {
        return type.task
    }
    
    var requestHeaders: [URLRequest.Header: String]? {
        let headers = HeaderConstants.defaultRequestHeaders.merging(type.requestHeaders ?? [:],
                                                            
                                                                    uniquingKeysWith: { first, _ in first })
        return headers
    }
}

// MARK: - AccessTokenAuthorizable

extension APITarget: AccessTokenAuthorizable {
    
    var authorizationType: Moya.AuthorizationType? {
        guard let accessToken = apiService?.apiToken, !accessToken.isEmpty else { return nil }
        return makeBearerTokenType(from: accessToken)
    }
}
