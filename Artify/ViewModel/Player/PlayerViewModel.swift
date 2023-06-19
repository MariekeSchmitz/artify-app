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
    
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    
    
    
//    func startTimer () {
//        DispatchQueue.global(qos: .background).async {
//            <#code#>
//        }
//    }
    
    
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
