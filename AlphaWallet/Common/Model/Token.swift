//
//  Token.swift
//  AlphaWallet
//
//  Created by Mukesh Shakya on 26/12/2023.
//

import Foundation

class WalletToken: Codable {
    
    var id: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "chainId"
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int?.self, forKey: .id) ?? nil
        name = try container.decodeIfPresent(String?.self, forKey: .name) ?? nil
    }
    
}
