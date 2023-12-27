//
//  Connection.swift
//  AlphaWallet
//
//  Created by Mukesh Shakya on 26/12/2023.
//

import Foundation

class Connection: Codable {
    
    var fromTokens: [WalletToken]?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fromTokens = try container.decodeIfPresent([WalletToken]?.self, forKey: .fromTokens) ?? nil
    }
    
}
