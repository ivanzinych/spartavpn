//
//  ApiService.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import Alamofire
import Moya

private let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
private let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
private let bearerToken = AccessTokenPlugin { _ in "" }
private let statusCodePlugin = StatusCodePlugin()

final class APIService {
    
#if DEBUG
    let plugins: [Moya.PluginType] = [networkLogger, bearerToken, statusCodePlugin]
#else
    let plugins: [Moya.PluginType] = [bearerToken, statusCodePlugin]
#endif

    let provider: MoyaProvider<AuthAPITarget>
    let userProvider: MoyaProvider<UserAPITarget>

    private var keychainService: KeychainServiceType
    
    init(keychainService: KeychainServiceType, sessionManager: Moya.Session = DefaultAlamofireSession.defaultSession) {
        let session: Alamofire.Session
        self.keychainService = keychainService
        session = DefaultAlamofireSession.defaultSession
        provider = .init(session: session, plugins: plugins)
        userProvider = .init(session: session, plugins: plugins)
    }
    
    func updateTokens(authModel: AuthModel? = nil) {
        keychainService.apiToken = authModel?.apiToken
    }
    
    var apiToken: String {
        guard let apiToken = keychainService.apiToken else {
            return ""
        }
        
        return apiToken
    }
}

// MARK: - Bearer header plugin support

extension TargetType {
    
    func makeBearerTokenType(from token: String) -> AuthorizationType {
        return .custom(token)
    }
}
