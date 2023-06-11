//
//  PlaylistLibrary.swift
//  Artify
//
//  Created by Marieke Schmitz on 22.05.23.
//

import Foundation

struct PlaylistLibrary : Decodable, Hashable {
    var items : Array<SimplifiedPlaylistObject> = []
}

struct SimplifiedPlaylistObject:Decodable, Hashable{
    var images: [ImageObject] = []
    var name: String = ""
    var id: String = ""
}

struct ImageObject: Decodable, Hashable {
    var url: String = ""
    var height: Int?
    var width: Int?
}

//struct TracksInformation: Decodable, Hashable {
//    var href: String = ""
//    var total: Int = 0
//}
