//
//  EnterCodeViewModel.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 28.09.2024.
//

import Foundation
 
class EnterCodeViewModel {
    
    let authApi: AuthAPIServiceType
    var authKeychainService: KeychainServiceType
    
    init(authApi: AuthAPIServiceType, authKeychainService: KeychainServiceType) {
        self.authApi = authApi
        self.authKeychainService = authKeychainService
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
    
    func clientValidation(email: String,
                          code: String,
                          successCompletion: (() -> ())?,
                          errorCompletion: ((APIErrorModel) -> ())?) {
        authApi.clientValidation(email: email,
                                 code: code) { [weak self] result in
            switch result {
            case .success(let model):
                self?.authKeychainService.apiToken = model.apiToken
                successCompletion?()
            case .failure(let error):
                errorCompletion?(error)
            }
        }
    }
}
