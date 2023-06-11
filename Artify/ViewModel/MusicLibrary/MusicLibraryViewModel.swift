//
//  PlaylistViewModel.swift
//  Artify
//
//  Created by Marieke Schmitz on 19.05.23.
//

import Foundation

class MusicLibraryViewModel : ObservableObject {
    
    static let shared = MusicLibraryViewModel()
    
    
    let libraryService = SpotifyLibraryService.shared
    @Published var track:Track = Track()
    @Published var favoriteTracks:TrackList = TrackList()
    @Published var playlistLibrary:PlaylistLibrary = PlaylistLibrary()
    

    @MainActor
    func getTrackById(id:String) {
        Task {
            let track:Track? = await libraryService.getTrackById(trackId: id)
            
            if let t = track {
                self.track = t
                print(self.track)
            }
        }
    }
    
    @MainActor
    func getFavouriteTracks() {
        Task {
            let tracks:TrackList? = await libraryService.getFavouriteTracks()
            
            if let t = tracks {
                favoriteTracks = t
                print(favoriteTracks)
            }
        }
    }
    
    @MainActor
    func getUsersPlaylists() {
        Task{
            let playlists:PlaylistLibrary? = await libraryService.getAllPlaylists()
            
            if let p = playlists {
                playlistLibrary = p
                print(playlistLibrary)
            }
        }
    }
}
