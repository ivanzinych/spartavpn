//
//  AuthModel.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import Foundation

struct AuthModel: Codable {
    let apiToken: String
    
    private enum CodingKeys: String, CodingKey {
        case apiToken = "token"
    }
}
