//
//  ConnectionList.swift
//  AlphaWallet
//
//  Created by Mukesh Shakya on 26/12/2023.
//

import Foundation

class ConnectionList: Codable {
    
    let connections: [Connection]?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        connections = try container.decodeIfPresent([Connection]?.self, forKey: .connections) ?? nil
    }
    
}
