//
//  SpotifyRequestService.swift
//  Artify
//
//  Created by Marieke Schmitz on 31.05.23.
//

import Foundation

class SpotifyLibraryService {
    
    static var shared:SpotifyLibraryService = SpotifyLibraryService()
    let urlService = SpotifyURLService.shared
    
    func getTrackById(trackId:String) async -> Track?{
        var urlRequest:URLRequest?
        urlRequest = urlService.getURLforRequest(type: .getTrackByID, data:trackId)
        return await getData(urlRequest: urlRequest)
    }
    
    func getFavouriteTracks() async -> TrackList?{
        var urlRequest:URLRequest?
        urlRequest = urlService.getURLforRequest(type: .getAllTracks)
        return await getData(urlRequest: urlRequest)
    }
    
    func getAllPlaylists() async -> PlaylistLibrary?{
        var urlRequest:URLRequest?
        urlRequest = urlService.getURLforRequest(type: .getAllPlaylists)
        return await getData(urlRequest: urlRequest)
    }
    
    func getPlaylistById(playlistId:String) async -> Playlist? {
        var urlRequest:URLRequest?
        urlRequest = urlService.getURLforRequest(type: .getPlaylistById, data:playlistId)
        return await getData(urlRequest: urlRequest)
    }
    
    func getData<T:Decodable>(urlRequest:URLRequest?) async -> T?{
        var decodedData:T?
        print(T.self)

        if let urlUnwrapped = urlRequest {
            print(urlUnwrapped)
            do {
                let (data, response) = try await URLSession.shared.data(for: urlUnwrapped)
                print(response)
                guard (response as? HTTPURLResponse)?.statusCode == 200 else { return nil }
                
                decodedData = try JSONDecoder().decode(T.self, from: data)
            } catch let error {
                print("Error fetching: ", error)
            }
            
        }
        return decodedData
    }
    
}
