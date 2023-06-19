//
//  TrackList.swift
//  Artify
//
//  Created by Marieke Schmitz on 01.06.23.
//

import Foundation

struct TrackList: Decodable, Identifiable, Hashable {
    let id = UUID()
    var href = ""
    var limit:Int = 0
    var next = ""
    var offset:Int = 0
    var total:Int = 0
    var items:[SavedTrackObject] = []
}
