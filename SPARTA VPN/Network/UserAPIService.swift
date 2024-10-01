//
//  UserAPIService.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 29.09.2024.
//

import Moya

protocol UserAPIServiceType {
    func client(completion: @escaping (Swift.Result<Void, APIErrorModel>) -> ())
    func servers(completion: @escaping (Swift.Result<ServersDataModel, APIErrorModel>) -> ())
}

extension APIService: UserAPIServiceType {
    
    func client(completion: @escaping (Swift.Result<Void, APIErrorModel>) -> ()) {
        userProvider.requestAPI(target: UserAPITarget(type: .client,
                                                      apiService: self),
                                completion: completion)
    }
    
    func servers(completion: @escaping (Swift.Result<ServersDataModel, APIErrorModel>) -> ()) {
        userProvider.requestAPI(target: UserAPITarget(type: .servers,
                                                      apiService: self),
                                completion: completion)
    }
}
