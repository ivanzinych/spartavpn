//
//  ServerModel.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 01.10.2024.
//

import Foundation

struct ServersDataModel: Codable {
    let servers: [ServerModel]
}

struct ServerModel: Codable {
    let name: String
    let link: String
    let description: String
}
