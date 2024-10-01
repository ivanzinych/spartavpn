//
//  UserAPI.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 29.09.2024.
//

import Moya

final class UserAPITarget: APITarget {
    
    init(type: UserAPI, apiService: APIService) {
        super.init(type: type, apiService: apiService)
    }
}

enum UserAPI {
    case client
    case servers
}

extension UserAPI: APITargetType {
    
    var path: String {
        switch self {
        case .client:
            return "/client"
        case .servers:
            return "/client/servers"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .client, .servers:
            return .requestPlain
        }
    }
}
