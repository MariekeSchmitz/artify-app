//
//  PlayerViewModel.swift
//  Artify
//
//  Created by Marieke Schmitz on 29.05.23.
//

import Foundation


protocol PlayerDataSource: AnyObject {
    var songName: String? {get}
//    var subtitle: String? {get}
//    var imageURL: URL? {get}
}

class PlayerViewModel: ObservableObject {
    
    static let shared = PlayerViewModel()
    
    private var track:Track?
    private var tracks:[Track] = []
    
    var currentTrack: Track? {
        if let track = track, tracks.isEmpty {
            return track
        } else if !tracks.isEmpty {
            return tracks.first
        }
        
        return nil
    }
    
    func startPlayback(track:Track) -> Void {
        self.track = track
        self.tracks = []
    }
    
}

extension PlayerViewModel : PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    
}
