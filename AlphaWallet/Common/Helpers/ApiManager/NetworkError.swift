//
//  NetworkError.swift
//  AlphaWallet
//
//  Created by Mukesh Shakya on 26/12/2023.
//

import Foundation

enum NetworkError: Error {
    
    case invalidURL
    case responseError
    case unknown
    case invalidResponse
    case decodingError(Error)
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .responseError:
            return "Unexpected status code"
        case .unknown:
            return "Something went wrong"
        case .invalidResponse:
            return "Invalid Response"
        case .decodingError(let error):
            return "Decoding Error: \(error.localizedDescription)"
        }
    }
    
}
