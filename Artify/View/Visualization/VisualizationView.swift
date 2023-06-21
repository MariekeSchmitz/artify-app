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
    @StateObject var playerVM: PlayerViewModel = PlayerViewModel.shared

    @State var counter = 0.00
    @State var counterOn = false
    @State var colorToggle = false

    var body: some View {
        ZStack {
            Rectangle().fill(colorToggle ? Color.red : Color.blue).ignoresSafeArea()
            if (playerVM.currentTrack != nil) {
                VStack {
                    Text(playerVM.currentTrack!.name)
                        .foregroundColor(.white)
                        .font(Font.custom("DMSerifDisplay-Regular", size: 60))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
//                        .frame(height:50)
                        .lineSpacing(0)
                    Text(playerVM.currentTrack!.artists[0].name)
                        .foregroundColor(.white)
                        .font(Font.custom("Poppins-Italic", size: 20))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
                
            }

//            Button("get Features") {
//                analysisVM.getTracksAudioFeatures(id: musicLibraryVM.track.id)
//            }
//            Button("get Analysis") {
////                analysisVM.getTracksAudioAnalysis(id: musicLibraryVM.track.id)
//            }
//            Button("get beats") {
//                print("____________________________")
//                print("BEATS")
//                print(analysisVM.audioAnalysis.beats)
//            }
//            Text("\(analysisVM.audioAnalysis.beats.count)").foregroundColor(.white)
//            Text("\(counter)").foregroundColor(.white)
            
        }
        .ignoresSafeArea()
        .onAppear{
            
            if (playerVM.currentTrack != nil) {
                playerVM.playCurrentTrack()
                counterOn = true
            }
           
        }
        .padding()
        .onReceive(analysisVM.timer) { time in
            if(counterOn) {
                self.counter += 0.01
                let roundedcounter = round(counter*100)/100
                if analysisVM.checkBeats(time:roundedcounter) {
                    colorToggle.toggle()
                }
                
                
            }
            
        }
        
    }
}

struct Animation_Previews: PreviewProvider {
    static var previews: some View {
        VisualizationView()
    }
}
