//
//  AudioAnalysis.swift
//  Artify
//
//  Created by Marieke Schmitz on 19.06.23.
//

import Foundation

struct AudioAnalysis : Decodable, Hashable {
    
    var track:AudioAnalysisTrack = AudioAnalysisTrack()
    var bars:[AudioAnalysisBar] = []
    var beats:[AudioAnalysisBeat] = []
    var sections:[AudioAnalysisSection] = []
    var segments:[AudioAnalysisSegment] = []
    var tatums:[AudioAnalysisTatum] = []
    
}

struct AudioAnalysisTrack : Decodable, Hashable {
    
    var num_samples: Int = 0
    var duration: Double = 0
    var sample_md5: String = ""
    var offset_seconds: Int = 0
    var window_seconds: Int = 0
    var analysis_sample_rate: Int = 0
    var analysis_channels: Int = 0
    var end_of_fade_in: Double = 0
    var start_of_fade_out: Double = 0
    var loudness: Double = 0
    var tempo: Double = 0
    var tempo_confidence: Double = 0
    var time_signature: Int = 0
    var time_signature_confidence: Double = 0
    var key: Int = 0
    var key_confidence: Double = 0
    var mode: Int = 0
    var mode_confidence: Double = 0
//    var codestring: String = ""
    var code_version: Double = 0
//    var echoprintstring: String = ""
    var echoprint_version: Double = 0
//    var synchstring: String = ""
    var synch_version: Double = 0
//    var rhythmstring: String = ""
    var rhythm_version: Double = 0
    
}

struct AudioAnalysisSegment: Decodable, Hashable {
    var start: Double = 0
    var duration: Double = 0
    var confidence: Double = 0
    var loudness_start: Double = 0
    var loudness_max_time: Double = 0
    var loudness_max: Double = 0
    var loudness_end: Double = 0
    var pitches: [Double] = []
    var timbre: [Double] = []
}

struct AudioAnalysisTatum: Decodable, Hashable {
    var start: Double = 0
    var duration: Double = 0
    var confidence: Double = 0
}

struct AudioAnalysisBeat: Decodable, Hashable {
    var start: Double = 0
    var duration: Double = 0
    var confidence: Double = 0
}

struct AudioAnalysisBar: Decodable, Hashable {
    var start: Double = 0
    var duration: Double = 0
    var confidence: Double = 0
}

struct AudioAnalysisSection: Decodable, Hashable {
    var start: Double = 0
    var duration: Double = 0
    var confidence: Double = 0
    var loudness: Double = 0
    var tempo: Double = 0
    var key: Int = 0
    var mode: Int = 0
    var time_signature: Int = 0
}
