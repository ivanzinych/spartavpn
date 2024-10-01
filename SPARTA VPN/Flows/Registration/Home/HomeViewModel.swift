//
//  HomeViewModel.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 01.10.2024.
//

import Foundation
 
class HomeViewModel {
    
    let userApi: UserAPIServiceType
    
    init(userApi: UserAPIServiceType) {
        self.userApi = userApi
    }
    
    func getServers(successCompletion: (([ServerModel]) -> ())?, errorCompletion: ((APIErrorModel) -> ())?) {
        userApi.servers { result in
            switch result {
            case .success(let models):
                successCompletion?(models.servers)
            case .failure(let error):
                errorCompletion?(error)
            }
        }
    }
}
