//
//  PlayerViewModel.swift
//  Artify
//
//  Created by Marieke Schmitz on 01.06.23.
//

import Foundation

class PlayerViewModel : ObservableObject {
    
    @Published var currentTrack:Track?
    var currentPlaylist:Playlist?
    let player:SpotifyPlayerService = SpotifyPlayerService.shared
    static let shared = PlayerViewModel()
    
    
    
    
//    func startTimer () {
//        DispatchQueue.global(qos: .background).async {
//            <#code#>
//        }
//    }
    
    
    func playCurrentTrack() {
        if let t = currentTrack {
            playTrack(id: t.uri)
        }
    }
    
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
