//
//  AudioFeatures.swift
//  Artify
//
//  Created by Marieke Schmitz on 19.06.23.
//

import Foundation

struct AudioFeatures:Decodable, Hashable {
    
    var acousticness : Float = 0
    var analysis_url: String = ""
    var danceability: Float = 0
    var duration_ms: Int = 0
    var energy: Float = 0
    var id: String = ""
    var instrumentalness: Float = 0
    var key: Int = 0
    var liveness: Float = 0
    var loudness: Float = 0
    var mode: Int = 0
    var speechiness: Float = 0
    var tempo: Float = 0
    var time_signature: Int = 0
    var track_href: String = ""
    var valence: Float = 0
    
}
