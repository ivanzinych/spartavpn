//
//  StatusCodePlugin.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import Moya

final class StatusCodePlugin: PluginType {
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        switch result {
        case .success(let response):
            switch response.statusCode {
            case 200...299:
                return .success(response)
            default:
                let error = MoyaError.statusCode(response)
                return .failure(error)
            }
        case .failure:
            return result
        }
    }
}
