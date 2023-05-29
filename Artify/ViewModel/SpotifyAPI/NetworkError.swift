//
//  NetworkError.swift
//  Artify
//
//  Created by Marieke Schmitz on 27.05.23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse
    case generalError
    case invalidToken
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidServerResponse:
            return "InvalidServerResponse"
        case .generalError:
            return "GeneralError"
        case .invalidToken:
            return "Invalid Token"
            
        }
    }
}
