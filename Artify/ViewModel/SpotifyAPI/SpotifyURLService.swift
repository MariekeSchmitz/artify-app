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
    
    // function to build URL to request Access Token
    func getAccessTokenURL() -> URLRequest? {
        var components = URLComponents()
        
        //build url to get token
        components.scheme = "https"
        components.host = APIConstants.authHost
        components.path = "/authorize"
        
        // map authParams into URLQueryItems
        components.queryItems = APIConstants.authParams.map({URLQueryItem(name: $0, value: $1)})
        
        guard let url = components.url else {return nil}
        
        print("Request-URL: \(url)")
        
        return URLRequest(url: url)
    }
    
    // function to build URL to request all albums of an artist by artistId
    func getAlbumsByArtistURL(artistId:String) -> URLRequest? {
        
        var components = URLComponents()
        
        //build url to get song
        components.scheme = "https"
        components.host = APIConstants.apiHost
        components.path = "/v1/artists/\(artistId)/albums"
        guard let url = components.url else {return nil}

        var urlRequest = URLRequest(url:url)
        
        // Header with token
        let token:String = UserDefaults.standard.value(forKey: "Authorization") as! String
        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json ", forHTTPHeaderField: "Content-Type")
                
        // HTTP Method
        urlRequest.httpMethod = "GET"
        
        return urlRequest
    }
    
    func getTrackById(trackID:String) -> URLRequest? {
        
        var components = URLComponents()
        
        //build url to get song
        components.scheme = "https"
        components.host = APIConstants.apiHost
        components.path = "/v1/tracks/\(trackID)"
        guard let url = components.url else {return nil}

        var urlRequest = URLRequest(url:url)
        
        // Header with token
        let token:String = UserDefaults.standard.value(forKey: "Authorization") as! String
        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json ", forHTTPHeaderField: "Content-Type")
        
        // HTTP Method
        urlRequest.httpMethod = "GET"
        
        return urlRequest
    }
    
    func getPausePlayerURL() -> URLRequest? {
        
        var components = URLComponents()
        
        //build url to get song
        components.scheme = "https"
        components.host = APIConstants.apiHost
        components.path = "/v1/me/player/pause"
        guard let url = components.url else {return nil}

        var urlRequest = URLRequest(url:url)
        
        
        // Header with token
        let token:String = UserDefaults.standard.value(forKey: "Authorization") as! String
    
        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json ", forHTTPHeaderField: "Content-Type")
        
        // HTTP Method
        urlRequest.httpMethod = "PUT"
        
        
        return urlRequest
        
    }
    
    func getPlayTrackURL(_ uri:String) -> URLRequest? {
        
        var components = URLComponents()
        
        //build url to get song
        components.scheme = "https"
        components.host = APIConstants.apiHost
        components.path = "/v1/me/player/play"
        guard let url = components.url else {return nil}

        var urlRequest = URLRequest(url:url)
        
        
        // Header with token
        let token:String = UserDefaults.standard.value(forKey: "Authorization") as! String
    
        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json ", forHTTPHeaderField: "Content-Type")
        
        // HTTP Method
        urlRequest.httpMethod = "PUT"
        
//        let postString = "userId=300&title=My urgent task&completed=false";
//
        let body = ["uris": ["\(uri)"]]
        let bodyData = try? JSONSerialization.data(
            withJSONObject: body,
            options: []
        )
        
//        // HTTP Body
        urlRequest.httpBody = bodyData
        
        return urlRequest
        
    }
    
    func getPlayNextTrackURL() -> URLRequest? {
        
        var components = URLComponents()
        
        //build url to get song
        components.scheme = "https"
        components.host = APIConstants.apiHost
        components.path = "/v1/me/player/next"
        guard let url = components.url else {return nil}

        var urlRequest = URLRequest(url:url)
        
        
        // Header with token
        let token:String = UserDefaults.standard.value(forKey: "Authorization") as! String
    
        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json ", forHTTPHeaderField: "Content-Type")
        
        // HTTP Method
        urlRequest.httpMethod = "POST"
        
//        let postString = "userId=300&title=My urgent task&completed=false";
//
//        // HTTP Body
//        urlRequest.httpBody = "'uris' : ['spotify:track:4iV5W9uYEdYUVa79Axb7Rh']".data(using: String.Encoding.utf8)
        
        return urlRequest
        
    }
    
    func getPlayPreviousTrackURL() -> URLRequest? {
        
        var components = URLComponents()
        
        //build url to get song
        components.scheme = "https"
        components.host = APIConstants.apiHost
        components.path = "/v1/me/player/previous"
        guard let url = components.url else {return nil}

        var urlRequest = URLRequest(url:url)
        
        
        // Header with token
        let token:String = UserDefaults.standard.value(forKey: "Authorization") as! String
    
        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json ", forHTTPHeaderField: "Content-Type")
        
        // HTTP Method
        urlRequest.httpMethod = "POST"
        
//        let postString = "userId=300&title=My urgent task&completed=false";
//
//        // HTTP Body
//        urlRequest.httpBody = "'uris' : ['spotify:track:4iV5W9uYEdYUVa79Axb7Rh']".data(using: String.Encoding.utf8)
        
        return urlRequest
        
    }
    
    
    
    
    
    
//    // function to build URL to request Song
//    func requestSongURL(trackId: String) -> URLRequest? {
//
//        var components = URLComponents()
//
//        //build url to get song
//        components.scheme = "https"
//        components.host = APIConstants.apiHost
//        components.path = "v1/tracks/\(trackId)"
//        guard let url = components.url else {return nil}
//
//        var urlRequest = URLRequest(url:url)
//
//        // Header with token
//        let token:String = UserDefaults.standard.value(forKey: "Authorization") as! String
//        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
//        urlRequest.addValue("application/json ", forHTTPHeaderField: "Content-Type")
//
//        // HTTP Method
//        urlRequest.httpMethod = "GET"
//
//        return urlRequest
//
//    }
//
//
//    func getTrackById(requestedTrackId:String) async throws -> (){
//
//        guard let url:URLRequest = requestSongURL(trackId: requestedTrackId) else {
//            throw NetworkError.invalidURL
//        }
//
//        let (data, _) = try await URLSession.shared.data(for: url)
//
//        print(data)
//
////        let decoder = JSONDecoder()
////        let results = try decoder.decode(Response.self, from: data)
////
////        print(results)
//
//
//
//    }
//
//
//
//    struct Response: Codable {
//        let tracks: Track
//    }
//
//    struct Track: Codable {
//        let items: [Item]
//    }
//
//    struct Item: Codable {
//        let name: String
//    }
//
    
}
