//
//  TokenListApi.swift
//  AlphaWallet
//
//  Created by Mukesh Shakya on 26/12/2023.
//

import Foundation

protocol TokenListApi {
    
    func fetchTokenList(completion: @escaping (Result<[WalletToken], Error>) -> Void)
    
}

extension TokenListApi {
    
    func fetchTokenList(completion: @escaping (Result<[WalletToken], Error>) -> Void) {
        let parameter: [String: Any] = [
            "fromChain": 1,
            "toChain": 1
        ]
        let endPoint = EndPoint(path: "connections", method: "GET", parameter: parameter)
        ApiManager.shared.request(endPoint.request.request, decodingType: ConnectionList.self) { result in
            switch result {
            case .success(let model):
                completion(.success(model.connections?.first?.fromTokens ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
