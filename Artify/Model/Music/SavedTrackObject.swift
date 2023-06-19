//
//  SavedTrackObject.swift
//  Artify
//
//  Created by Marieke Schmitz on 01.06.23.
//

import Foundation

struct SavedTrackObject: Decodable, Identifiable, Hashable {
    let id = UUID()
    var track:Track
   
    enum CodingKeys: String, CodingKey {
        case track
        

    }
}
