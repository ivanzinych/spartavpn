//
//  AppConfiguration.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import Foundation

class AppConfiguration {
    
    enum Environment {
        case develop
        case production
        
        var baseURL: URL {
            switch self {
            case .develop: return URL(string: "https://stage.ssvpnapp.win/api/v1/mobile")!
            case .production: return URL(string: "https://stage.ssvpnapp.win/api/v1/mobile")!
            }
        }
    }
    
    static var environment: Environment {
        #if DEBUG
            return .develop
        #else
            return .production
        #endif
    }
}
