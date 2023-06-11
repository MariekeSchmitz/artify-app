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

        case .getAllPlaylists, .getAllTracks, .getTrackByID, .getPlaylistById:
            urlRequest.httpMethod = HTTPmethods.get

        }
        
        
        return urlRequest

    }
    
    
//    func getURLHeader(components:URLComponents) -> URLRequest? {
//
//        guard let url = components.url else {return nil}
//
//        var urlRequest = URLRequest(url:url)
//
//        // Header with token
//        let token:String = UserDefaults.standard.value(forKey: "Authorization") as! String
//        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
//        urlRequest.addValue("application/json ", forHTTPHeaderField: "Content-Type")
//
//        return urlRequest
//
//    }
    
//    func getURLLibraryRequest() -> URLRequest? {
//
//
//
//    }
//
//    func getURLPlayerRequest() -> URLRequest? {
//        getURLLibraryRequest(data: <#T##String?#>)
//    }
//
    
    // function to build URL to request all albums of an artist by artistId
//    func getAlbumsByArtistURL(artistId:String) -> URLRequest? {
//
//        var components = URLComponents()
//
//        //build url to get song
//        components.scheme = "https"
//        components.host = APIConstants.apiHost
//        components.path = "/v1/artists/\(artistId)/albums"
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
//    }
    
//    func getTrackById(trackID:String) -> URLRequest? {
//
//        var components = URLComponents()
//
//        //build url to get song
//        components.scheme = "https"
//        components.host = APIConstants.apiHost
//        components.path = "/v1/tracks/\(trackID)"
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
//    }
    
//    func getPausePlayerURL() -> URLRequest? {
//
//        var components = URLComponents()
//
//        //build url to get song
//        components.scheme = "https"
//        components.host = APIConstants.apiHost
//        components.path = "/v1/me/player/pause"
//        guard let url = components.url else {return nil}
//
//        var urlRequest = URLRequest(url:url)
//
//
//        // Header with token
//        let token:String = UserDefaults.standard.value(forKey: "Authorization") as! String
//
//        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
//        urlRequest.addValue("application/json ", forHTTPHeaderField: "Content-Type")
//
//        // HTTP Method
//        urlRequest.httpMethod = "PUT"
//
//
//        return urlRequest
//
//    }
    
//    func getPlayTrackURL(_ uri:String) -> URLRequest? {
//
//        var components = URLComponents()
//
//        //build url to get song
//        components.scheme = "https"
//        components.host = APIConstants.apiHost
//        components.path = "/v1/me/player/play"
//        guard let url = components.url else {return nil}
//
//        var urlRequest = URLRequest(url:url)
//
//
//        // Header with token
//        let token:String = UserDefaults.standard.value(forKey: "Authorization") as! String
//
//        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
//        urlRequest.addValue("application/json ", forHTTPHeaderField: "Content-Type")
//
//        // HTTP Method
//        urlRequest.httpMethod = "PUT"
//
////        let postString = "userId=300&title=My urgent task&completed=false";
////
//        let body = ["uris": ["\(uri)"]]
//        let bodyData = try? JSONSerialization.data(
//            withJSONObject: body,
//            options: []
//        )
//
////        // HTTP Body
//        urlRequest.httpBody = bodyData
//
//        return urlRequest
//
//    }
    
//    func getPlayNextTrackURL() -> URLRequest? {
//
//        var components = URLComponents()
//
//        //build url to get song
//        components.scheme = "https"
//        components.host = APIConstants.apiHost
//        components.path = "/v1/me/player/next"
//        guard let url = components.url else {return nil}
//
//        var urlRequest = URLRequest(url:url)
//
//
//        // Header with token
//        let token:String = UserDefaults.standard.value(forKey: "Authorization") as! String
//
//        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
//        urlRequest.addValue("application/json ", forHTTPHeaderField: "Content-Type")
//
//        // HTTP Method
//        urlRequest.httpMethod = "POST"
//
////        let postString = "userId=300&title=My urgent task&completed=false";
////
////        // HTTP Body
////        urlRequest.httpBody = "'uris' : ['spotify:track:4iV5W9uYEdYUVa79Axb7Rh']".data(using: String.Encoding.utf8)
//
//        return urlRequest
//
//    }
    
//    func getPlayPreviousTrackURL() -> URLRequest? {
//
//        var components = URLComponents()
//
//        //build url to get song
//        components.scheme = "https"
//        components.host = APIConstants.apiHost
//        components.path = "/v1/me/player/previous"
//        guard let url = components.url else {return nil}
//
//        var urlRequest = URLRequest(url:url)
//
//
//        // Header with token
//        let token:String = UserDefaults.standard.value(forKey: "Authorization") as! String
//
//        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
//        urlRequest.addValue("application/json ", forHTTPHeaderField: "Content-Type")
//
//        // HTTP Method
//        urlRequest.httpMethod = "POST"
//
////        let postString = "userId=300&title=My urgent task&completed=false";
////
////        // HTTP Body
////        urlRequest.httpBody = "'uris' : ['spotify:track:4iV5W9uYEdYUVa79Axb7Rh']".data(using: String.Encoding.utf8)
//
//        return urlRequest
//
//    }
    
    
    
    
    
    
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
