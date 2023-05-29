//
//  APIManager.swift
//  Artify
//
//  Created by Marieke Schmitz on 26.05.23.
//

import Foundation
import Combine

class APIManager<T: Decodable> {
    
    struct RequestModel {
        let url:URL?
        let method:HTTPMethod
    }
    
    static var shared: APIManager<T> {
        return APIManager<T>()
    }
    
    private init() {}
    
    func request(with model:RequestModel) -> AnyPublisher<T, Error> {
        let tokenPublisher = AuthManager.shared.getAccessToken()
        return tokenPublisher
            .flatMap { tokenKey -> AnyPublisher<T,Error>  in
                guard let url = model.url else {
                    return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
                }
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = model.method.rawValue
                switch model.method {
                case .get:
                    urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenKey)"]
                default:
                    break
                }
                return URLSession.shared
                    .dataTaskPublisher(for: urlRequest)
                                        .tryMap({ data, response in
                                            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                                                throw URLError(.badServerResponse)
                                            }
                                            return data
                                        })
                                        .decode(type: T.self, decoder: JSONDecoder())
                                        .receive(on: DispatchQueue.main)
                                        .eraseToAnyPublisher()
                                }
                                .receive(on: DispatchQueue.main)
                                .eraseToAnyPublisher()
            
    }    
}
