//
//  SONG.swift
//  Artify
//
//  Created by Marieke Schmitz on 22.05.23.
//

import Foundation

struct Track: Decodable, Hashable {
//    let id = UUID()
    var id: String = ""
    var name: String = ""
    var uri: String = ""
    var artists: [Artist] = []
    
   
    enum CodingKeys: String, CodingKey {
        case name
        case uri
        case artists
        case id
    }
}
