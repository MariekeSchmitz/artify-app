//
//  DataAnalysisViewModel.swift
//  Artify
//
//  Created by Marieke Schmitz on 19.06.23.
//

import Foundation

class MusicAnalysisViewModel : ObservableObject {
    
    static let shared = MusicAnalysisViewModel()
    let analysisService = SpotifyAnalysisService.shared
    @Published var audioFeatures: AudioFeatures = AudioFeatures()
    @Published var audioAnalysis: AudioAnalysis = AudioAnalysis()
    var indexBeats: Int = 0
    
    
    let timer = Timer
        .publish(every: 0.01, on: .main, in: .common)
        .autoconnect()
    
    func checkBeats(time:Double) -> Bool {
        print(time)
        let beats = audioAnalysis.beats
        for beat in beats {
            let roundedBeatStart = round(beat.start * 100) / 100.00
//            print("ROUNDEDBEAT: \(roundedBeatStart)")
            if roundedBeatStart == time {
                return true
            }
        }
        
        return false
    }
    
    
//    @MainActor
    func getTracksAudioFeatures(id: String) async {
        
//        Task {
            let features:AudioFeatures? = await analysisService.getAudioFeatures(trackId: id)
            if let f = features {
                self.audioFeatures = f
//                print(self.audioFeatures)
            }
//        }
        
    }
    
//    @MainActor
    func getTracksAudioAnalysis(id: String) async {
        
//        Task {
            let analysis:AudioAnalysis? = await analysisService.getAudioAnalysis(trackId: id)
            if let a = analysis {
                self.audioAnalysis = a
//                print(self.audioAnalysis)
            }
//        }
        
    }
    
    
    
}
