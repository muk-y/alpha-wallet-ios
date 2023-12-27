//
//  ApiManager.swift
//  AlphaWallet
//
//  Created by Mukesh Shakya on 26/12/2023.
//

import Foundation
import HTTPClient

class ApiManager {
    
    static let shared = ApiManager()
    
    private init() {}
    
    func request<T: Decodable>(_ request: URLRequest, decodingType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        Task {
            do {
                let httpClient: HTTPClient = URLSessionHTTPClient()
                let (data, response) = try await httpClient.sendRequest(request)
                DispatchQueue.main.async {
                    if !(200...299 ~= response.statusCode) {
                        completion(.failure(NSError(domain: "error", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: NetworkError.unknown.errorDescription])))
                        return
                    }
                    do {
                        if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                            debugPrint(json)
                        }
                        let decodedObject = try JSONDecodable<T>.decode(from: data)
                        completion(.success(decodedObject as T))
                    } catch {
                        completion(.failure(NetworkError.decodingError(error)))
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func request(_ request: URLRequest, completion: @escaping (Result<String, Error>) -> Void) {
        Task {
            do {
                let httpClient: HTTPClient = URLSessionHTTPClient()
                let (data, response) = try await httpClient.sendRequest(request)
                DispatchQueue.main.async {
                    if !(200...299 ~= response.statusCode) {
                        completion(.failure(NSError(domain: "error", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: NetworkError.unknown.errorDescription])))
                        return
                    }
                    if let text = String(data: data, encoding: .utf8) {
                        completion(.success(text))
                    } else {
                        let decodingError = NSError(domain: "error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response as text."])
                        completion(.failure(decodingError))
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func requestExpectingNoResponse(_ request: URLRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        Task {
            do {
                let httpClient: HTTPClient = URLSessionHTTPClient()
                let (data, response) = try await httpClient.sendRequest(request)
                DispatchQueue.main.async {
                    if !(200...299 ~= response.statusCode) {
                        completion(.failure(NSError(domain: "error", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: NetworkError.unknown.errorDescription])))
                        return
                    }
                    // If there's no data, consider it a successful response with no content
                    if data.isEmpty {
                        completion(.success(()))
                    } else {
                        if String(data: data, encoding: .utf8) != nil {
                            completion(.success(()))
                        } else {
                            let decodingError = NSError(domain: "error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response as text."])
                            completion(.failure(decodingError))
                        }
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
}

protocol HTTPClient {
    
   func sendRequest(_ request: URLRequest) async throws -> (Data, HTTPURLResponse)
    
}

class URLSessionHTTPClient: HTTPClient {
    
    func sendRequest(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        return (data, httpResponse)
    }
    
}

struct JSONDecodable<T: Decodable>: DecodableResponse {
    
   typealias DecodableType = T
   
   static func decode(from data: Data) throws -> T {
       return try JSONDecoder().decode(T.self, from: data)
   }
    
}

protocol DecodableResponse {
    
   associatedtype DecodableType: Decodable
   static func decode(from data: Data) throws -> DecodableType
    
}
