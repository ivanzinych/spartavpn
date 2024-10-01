//
//  ErrorModel.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import Foundation

struct APIErrorModel: Error, Codable {
    let message: String
    let errors: APIErrorDetailsModel?
    
    init(message: String) {
        self.message = message
        self.errors = nil
    }
}

struct APIErrorDetailsModel: Error, Codable {
    let email: [String]?
}

struct APIErrorMessageModel: Error, Codable {
    let message: String
}
