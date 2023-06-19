//
//  Artists.swift
//  Artify
//
//  Created by Marieke Schmitz on 11.06.23.
//

import Foundation

struct Artists: Decodable, Identifiable, Hashable {
    let id = UUID()
    var artists: Array<Artist> = []
}
