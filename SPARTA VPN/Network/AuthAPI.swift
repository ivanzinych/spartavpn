//
//  AuthAPI.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import Moya

final class AuthAPITarget: APITarget {
    
    init(type: AuthAPI, apiService: APIService) {
        super.init(type: type, apiService: apiService)
    }
}

enum AuthAPI {
    case sendCode(email: String)
    case clientValidation(email: String, code: String)
}

extension AuthAPI: APITargetType {
    
    var path: String {
        switch self {
        case .sendCode:
            return "/code"
        case .clientValidation:
            return "/client/validation"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .sendCode(email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding())
        case .clientValidation(email: let email, code: let code):
            return .requestParameters(parameters: ["email": email, "code": code, "device_id": UUID().uuidString], encoding: JSONEncoding())
        }
    }
}
