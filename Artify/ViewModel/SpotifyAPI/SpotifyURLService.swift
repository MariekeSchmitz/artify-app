//
//  SpotifyService.swift
//  Artify
//
//  Created by Marieke Schmitz on 22.05.23.
//

import Foundation

class SpotifyURLService {
    
    // Singleton
    static let shared = SpotifyURLService()
    
    
    // build URL to request Access Token
    func getAccessTokenURL() -> URLRequest? {
        var components = URLComponents()
        
        //build url to get token
        components.scheme = APIConstants.scheme
        components.host = APIConstants.authHost
        components.path = APIConstants.authorizePath
        
        // map authParams into URLQueryItems
        components.queryItems = APIConstants.authParams.map({URLQueryItem(name: $0, value: $1)})
        
        guard let url = components.url else {return nil}
        
        return URLRequest(url: url)
    }
    
    func getURLforRequest(type:RequestTypes, id:String = "") -> URLRequest? {
        
        var components = URLComponents()
        var urlRequest: URLRequest
        components.scheme = APIConstants.scheme
        components.host = APIConstants.apiHost
        
        // path for request
        switch type {
            
        case .playTrack:
            components.path = "/v1/me/player/play"
            
        case .pauseTrack:
            components.path = "/v1/me/player/pause"
            
        case .resumeTrack:
            components.path = "/v1/me/player/play"
            
        case .nextTrack:
            components.path = "/v1/me/player/next"
            
        case .previousTrack:
            components.path = "/v1/me/player/previous"
            
        case .getAllPlaylists:
            components.path = "/v1/me/playlists"
            
        case .getAllTracks:
            components.path = "/v1/me/tracks"
            
        case .getTrackByID:
            components.path = "/v1/tracks/\(id)"
            
        case .getPlaylistById:
            components.path = "/v1/playlists/\(id)/tracks"
            
        case .audioFeatures:
            components.path = "/v1/audio-features/\(id)"
            
        case .audioAnalysis:
            components.path = "/v1/audio-analysis/\(id)"
            
        }
        
        

        // header with token
        guard let url = components.url else {return nil}
        urlRequest = URLRequest(url:url)
        let token:String = UserDefaults.standard.value(forKey: "Authorization") as! String
        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json ", forHTTPHeaderField: "Content-Type")
        
        
        
        // http method and optional body
        switch type {
        
        case .playTrack:
            urlRequest.httpMethod = HTTPmethods.put
            
            let body = ["uris": ["\(id)"]]
            let bodyData = try? JSONSerialization.data(
                withJSONObject: body,
                options: []
            )
            urlRequest.httpBody = bodyData

        case .pauseTrack, .resumeTrack:
            urlRequest.httpMethod = HTTPmethods.put

        case .nextTrack, .previousTrack:
            urlRequest.httpMethod = HTTPmethods.post

        case .getAllPlaylists, .getAllTracks, .getTrackByID, .getPlaylistById, .audioFeatures, .audioAnalysis:
            urlRequest.httpMethod = HTTPmethods.get

        }
        
        
        return urlRequest

    }
    
  
    
}
