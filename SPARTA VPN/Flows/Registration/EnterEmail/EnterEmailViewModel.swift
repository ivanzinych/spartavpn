//
//  EnterEmailViewModel.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 28.09.2024.
//

import Foundation
 
class EnterEmailViewModel {
    
    let authApi: AuthAPIServiceType
    
    init(authApi: AuthAPIServiceType) {
        self.authApi = authApi
    }
    
    func sendCode(email: String, successCompletion: (() -> ())?, errorCompletion: ((APIErrorModel) -> ())?) {
        authApi.sendCode(email: email) { result in
            switch result {
            case .success(let success):
                successCompletion?()
            case .failure(let error):
                errorCompletion?(error)
            }
        }
    }
}
