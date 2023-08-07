//
//  APIConstants.swift
//  Artify
//
//  Created by Marieke Schmitz on 27.05.23.
//

import Foundation

enum APIConstants {
    
    static let apiHost = "api.spotify.com"
    static let authHost = "accounts.spotify.com"
    static let clientID = "xxx"
    static let clientSecret = "xxx"
    static let redirectURL = "https://www.google.de/"
    static let responseType = "token"
    static let scopes = "streaming user-library-read user-modify-playback-state"
    static let scheme = "https"
    static let authorizePath = "/authorize"
    
    
    static var authParams = [
        "response_type": responseType,
        "client_id": clientID,
        "redirect_uri": redirectURL,
        "scope": scopes
    ]
    
    static var limit = [
        "limit": 5
    ]
}
