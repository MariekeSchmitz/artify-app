//
//  PlayerViewModel.swift
//  Artify
//
//  Created by Marieke Schmitz on 01.06.23.
//

import Foundation

class PlayerViewModel : ObservableObject {
    
    var currentTrack:Track?
    var currentPlaylist:Playlist?
    let player:SpotifyPlayerService = SpotifyPlayerService.shared
    static let shared = PlayerViewModel()
    
    func playTrack(id:String) {
        player.playTrack(trackURI:id)
    }
    
    func pauseTrack() {
        player.pauseTrack()
    }
    
    func resumeTrack() {
        player.resumeTrack()
    }
    
    func playNextTrack() {
        player.playNextTrack()
    }
    
    func playPreviousTrack() {
        player.playPreviousTrack()
    }
    
}
