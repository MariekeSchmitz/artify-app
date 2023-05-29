//
//  PlaylistViewModel.swift
//  Artify
//
//  Created by Marieke Schmitz on 19.05.23.
//

import Foundation

class MusicLibraryViewModel : ObservableObject {
    
    let spotifyUrlService:SpotifyURLService = SpotifyURLService.shared
    
    @Published var albums:ArtistAlbums = ArtistAlbums()
    @Published var track:Track = Track()
    
    func getAlbumsByArtistById(){
                        
        guard let urlRequest:URLRequest = spotifyUrlService.getAlbumsByArtistURL(artistId: "0n94vC3S9c3mb2HyNAOcjg") else {return}

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                guard let data = data else { return }
                print(data)
                DispatchQueue.main.async {
                    do {
                        let decodedAlbums = try JSONDecoder().decode(ArtistAlbums.self, from: data)
                        self.albums = decodedAlbums
                        print(self.albums)
                        print((self.albums.items)![0].name!)

                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
        
    }
    
    func getTrackById() {
        guard let urlRequest:URLRequest = spotifyUrlService.getTrackById(trackID: "1uUgy87UHT9rlbxHirty3g") else {return}
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                guard let data = data else { return }
                print(data)
                DispatchQueue.main.async {
                    do {
                        let decodedTrack = try JSONDecoder().decode(Track.self, from: data)
                        self.track = decodedTrack
                        print(self.track)
                        
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
            
            
        }
        dataTask.resume()

    }
    
    func pauseTrack() {
        
        guard let urlRequest:URLRequest = spotifyUrlService.getPausePlayerURL() else {return}
                        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            
            guard let response = response as? HTTPURLResponse else { return }
            print(response)

            if response.statusCode == 200 {
                guard let data = data else { return }
                print(data)
//                DispatchQueue.main.async {
//                    do {
//
//                    } catch let error {
//                        print("Error decoding: ", error)
//                    }
//                }
            }
            
            
        }
        
        dataTask.resume()
        
    }
    
    func playTrack() {
        guard let urlRequest:URLRequest = spotifyUrlService.getPlayTrackURL(self.track.uri) else {return}
        
//        print(urlRequest.url)
//        print(urlRequest.allHTTPHeaderFields)
//        print(urlRequest.httpBody?.description)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            print("HI")
            
            guard let response = response as? HTTPURLResponse else { return }
            print(response)
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                print(data)
            }
        }
        
        //    @Published private var model: PlaylistModel = PlaylistModel()
        dataTask.resume()

    }
    
    func playNextTrack() {
        guard let urlRequest:URLRequest = spotifyUrlService.getPlayNextTrackURL() else {return}
        
//        print(urlRequest.url)
//        print(urlRequest.allHTTPHeaderFields)
//        print(urlRequest.httpBody?.description)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            print("HI")
            
            guard let response = response as? HTTPURLResponse else { return }
            print(response)
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                print(data)
            }
        }
        
        //    @Published private var model: PlaylistModel = PlaylistModel()
        dataTask.resume()

    }
    
    func playPreviousTrack() {
        guard let urlRequest:URLRequest = spotifyUrlService.getPlayPreviousTrackURL() else {return}
        
//        print(urlRequest.url)
//        print(urlRequest.allHTTPHeaderFields)
//        print(urlRequest.httpBody?.description)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            print("HI")
            
            guard let response = response as? HTTPURLResponse else { return }
            print(response)
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                print(data)
            }
        }
        
        //    @Published private var model: PlaylistModel = PlaylistModel()
        dataTask.resume()

    }
    
     
    
}
