//
//  DefaultAlamofireSession.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import Alamofire

private enum SessionConstants {
    /// Глобальный таймаут
    static let maxRequestTimeout = 90.0
}

final class DefaultAlamofireSession: Alamofire.Session {
    
    static let configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = SessionConstants.maxRequestTimeout
        configuration.timeoutIntervalForResource = SessionConstants.maxRequestTimeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return configuration
    }()
    
    /// Дефолтная сессия с доверием к самоподписанным сертификатам
    static let defaultSession: DefaultAlamofireSession = {
        return DefaultAlamofireSession(configuration: configuration,
                                       serverTrustManager: .none)
    }()
}
