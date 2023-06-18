//
//  PlaylistViewModel.swift
//  Artify
//
//  Created by Marieke Schmitz on 11.06.23.
//

import Foundation

class PlaylistViewModel : ObservableObject {
    
    let libraryService = SpotifyLibraryService.shared
    
    @Published var playlist:Playlist = Playlist()
    
    
    @MainActor
    func getAllTracksInPlaylist(playlistId:String) {
        
        Task {
            let playlist:Playlist? = await libraryService.getPlaylistById(playlistId: playlistId)
            if let p = playlist {
                self.playlist = p
                print(self.playlist)
            }
        }
    }
    
}
