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

    @MainActor
    func getTracksAudioFeatures(id: String) {
        
        Task {
            let features:AudioFeatures? = await analysisService.getAudioFeatures(trackId: id)
            if let f = features {
                self.audioFeatures = f
                print(self.audioFeatures)
            }
        }
        
    }
    
    @MainActor
    func getTracksAudioAnalysis(id: String) {
        
        Task {
            let analysis:AudioAnalysis? = await analysisService.getAudioAnalysis(trackId: id)
            if let a = analysis {
                self.audioAnalysis = a
                print(self.audioAnalysis)
            }
        }
        
    }
    
}
