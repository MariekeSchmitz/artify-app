//
//  PlayerViewModel.swift
//  Artify
//
//  Created by Marieke Schmitz on 01.06.23.
//

import Foundation

class PlayerViewModel : ObservableObject {
    
    static let shared = PlayerViewModel()
    @Published var currentTrack:Track?
    @Published var isPlayling:Bool = false
    @Published var currentTIme:Double = 0
    var currentTimeAllowsChange: Bool = true
    var offset:Double = 0
    var songForwarded:Bool = false
    
    var currentPlaylist:Playlist?
    let player:SpotifyPlayerService = SpotifyPlayerService.shared
    
    
    func playCurrentTrack() {
        isPlayling = true
        if let t = currentTrack {
            playTrack(id: t.uri)
        }
    }
    
    func playTrack(id:String) {
        currentTimeAllowsChange = true
        isPlayling = true
        offset = 0
        songForwarded = false
        player.playTrack(trackURI:id)
    }
    
    func seekToPositionInTrack(time_s:Double) {
        offset = time_s
        songForwarded = true
//        currentTimeAllowsChange = true
        let time_ms = Int(time_s * 1000)
        player.seekToPositionInTrack(time_ms: String(time_ms))
    }
    
    func pauseTrack() {
        isPlayling = false
        player.pauseTrack()
    }
    
    func resumeTrack() {
        isPlayling = true
        player.resumeTrack()
    }
    
    func playNextTrack() {
        player.playNextTrack()
    }
    
    func playPreviousTrack() {
        player.playPreviousTrack()
    }
    
    func setCurrentTime(time:Double) {
        if currentTimeAllowsChange {
            currentTIme = time
        }
             
    }
    
}
