//
//  Animation.swift
//  Artify
//
//  Created by Marieke Schmitz on 19.06.23.
//

import SwiftUI

struct VisualizationView:View {
    @StateObject var musicLibraryVM: MusicLibraryViewModel = MusicLibraryViewModel.shared
    @StateObject var analysisVM: MusicAnalysisViewModel = MusicAnalysisViewModel.shared

    var body: some View {
        VStack {
            Text(musicLibraryVM.track.name).foregroundColor(.white)
            Button("get Features") {
                analysisVM.getTracksAudioFeatures(id: musicLibraryVM.track.id)
            }
            Button("get Analysis") {
                analysisVM.getTracksAudioAnalysis(id: musicLibraryVM.track.id)
            }
            Button("get beats") {
                print("____________________________")
                print("BEATS")
                print(analysisVM.audioAnalysis.beats)
            }
            
        }.padding()
        
    }
}

struct Animation_Previews: PreviewProvider {
    static var previews: some View {
        VisualizationView()
    }
}
