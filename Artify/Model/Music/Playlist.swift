//
//  playlistModel.swift
//  Artify
//
//  Created by Marieke Schmitz on 19.05.23.
//

import Foundation

struct Playlist:Decodable, Hashable {
    var items : Array<PlaylistTrackObject> = []
}

struct PlaylistTrackObject:Decodable, Hashable, Identifiable {
    let id = UUID()
    var track:Track = Track()
}
