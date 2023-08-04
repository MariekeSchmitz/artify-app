//
//  SONG.swift
//  Artify
//
//  Created by Marieke Schmitz on 22.05.23.
//

import Foundation

struct Track: Decodable, Hashable {
    var id: String = ""
    var name: String = ""
    var uri: String = ""
    var artists: [Artist] = []
    var duration_ms: Int = 0
    
   
    enum CodingKeys: String, CodingKey {
        case name
        case uri
        case artists
        case id
        case duration_ms

    }
}
