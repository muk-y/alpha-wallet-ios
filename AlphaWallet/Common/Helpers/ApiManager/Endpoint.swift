//
//  Endpoint.swift
//  AlphaWallet
//
//  Created by Mukesh Shakya on 26/12/2023.
//

import Foundation

class EndPoint {
    
    static let baseURL = "https://li.quest/v1"
    static let baseImageURL = "https://assets.lif3.com/wallet/chains"
    
    var needsAuthorization: Bool = false
    let path: String
    let method: String
    var parameter: [String: Any]?
    
    public init(path: String, method: String, needsAuthorization: Bool = false, parameter: [String: Any]? = nil) {
        self.path = path
        self.method = method
        self.needsAuthorization = needsAuthorization
        self.parameter = parameter
    }
    
    private func request(urlString: String, body: [String: Any]? = nil) -> HTTPRequest {
        var components = URLComponents(string: urlString)!
        if method == "GET" {
            components.queryItems = body?.compactMap({ (key, value) in
                if let intValue = value as? Int {
                    return URLQueryItem(name: key, value: "\(intValue)")
                } else if let doubleValue = value as? Double {
                    return URLQueryItem(name: key, value: "\(doubleValue)")
                } else if let stringValue = value as? String {
                    return URLQueryItem(name: key, value: stringValue)
                } else if let boolValue = value as? Bool {
                    return URLQueryItem(name: key, value: "\(boolValue)")
                }
                return nil
            })
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        }
        var request = URLRequest(url: components.url!)
        request.httpMethod = method
        if method == "POST" || method == "DELETE" || method == "PUT" || method == "PATCH" {
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if let body = body {
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            }
        }
        request.setValue(UserDefaults.standard.string(forKey: "LCLCurrentLanguageKey") ?? Locale.current.languageCode, forHTTPHeaderField: "Accept-Language")
        return HTTPRequest(request: request, endPoint: self)
    }
    
    func request(body: [String: Any]? = nil) -> HTTPRequest {
        let urlString = EndPoint.baseURL + "/" + path
        return request(urlString: urlString, body: body)
    }
    
    var request: HTTPRequest {
        let urlString = EndPoint.baseURL + "/" + path
        return request(urlString: urlString, body: parameter)
    }
    
}
