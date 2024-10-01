//
//  AuthAPIService.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import Moya

protocol AuthAPIServiceType {
    func sendCode(email: String,
                  completion: @escaping (Swift.Result<Void, APIErrorModel>) -> ())
    func clientValidation(email: String,
                          code: String,
                          completion: @escaping (Swift.Result<AuthModel, APIErrorModel>) -> ())
}

extension APIService: AuthAPIServiceType {
    
    func sendCode(email: String,
                  completion: @escaping (Swift.Result<Void, APIErrorModel>) -> ()) {
        provider.requestAPI(target: AuthAPITarget(type: .sendCode(email: email),
                                                  apiService: self),
                            completion: completion)
    }
    
    func clientValidation(email: String,
                          code: String,
                          completion: @escaping (Swift.Result<AuthModel, APIErrorModel>) -> ()) {
        provider.requestAPI(target: AuthAPITarget(type: .clientValidation(email: email, code: code),
                                                  apiService: self),
                            completion: completion)
    }
}
