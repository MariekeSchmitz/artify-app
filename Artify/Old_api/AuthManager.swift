//
//  AuthManager.swift
//  Artify
//
//  Created by Marieke Schmitz on 26.05.23.
//

import Foundation
import Combine

class AuthManager {
    
    static let shared = AuthManager()
    
    
    // generate Authentication Key
    private let authKey: String = {
        
        let clientID = "0e5b4c92168e4cf7971e3407e7b06284"
        let clientSecret = "8eb495076dfd49d5b254077b469a6c8b"
        
        let rawKey = "\(clientID):\(clientSecret)"
        let encodedKey = rawKey.data(using: .utf8)?.base64EncodedString() ?? ""
        return "Basic \(encodedKey)"
        
    }()
    
    // generate Authentication URL
    private let tokenURL:URL? = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "accounts.spotify.com"
        components.path = "/api/token"
        return components.url
    }()
    
    
    private init() {}
    
    // Request method for access token
    func getAccessToken() -> AnyPublisher<String, Error> {
        
        //strong token url
        guard let url = tokenURL else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        //url request setups
        var urlRequest = URLRequest(url: url)
        
        // request header
        urlRequest.allHTTPHeaderFields = ["Authorization": authKey,
                                          "Content-Type": "application/x-www-form-urlencoded"]
        
        // add query items for request body
        var requestBody = URLComponents()
        requestBody.queryItems = [URLQueryItem(name: "grant_type", value: "client_credentials")]
        urlRequest.httpBody = requestBody.query?.data(using: .utf8)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: AccessToken.self, decoder: JSONDecoder())
            .map {accessToken -> String in
                guard let token = accessToken.token else {
                    print("The access token is not fetched.")
                    return ""
                }
                return token
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
}



