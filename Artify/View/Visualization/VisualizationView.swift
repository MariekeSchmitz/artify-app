//
//  Animation.swift
//  Artify
//
//  Created by Marieke Schmitz on 19.06.23.
//

import SwiftUI
import PhotosUI

struct VisualizationView:View {
    @StateObject var musicLibraryVM: MusicLibraryViewModel = MusicLibraryViewModel.shared
    @StateObject var analysisVM: MusicAnalysisViewModel = MusicAnalysisViewModel.shared
    @StateObject var playerVM: PlayerViewModel = PlayerViewModel.shared

    @State var counter = 0.00
    @State var counterOn = false
    @State var colorToggle = false
    
    var visualizationView = VisualizationSpriteView()

    var body: some View {
        ZStack {
            // Shapes
//            Rectangle().fill(analysisVM.colorToggle ? Color.red : Color.blue).ignoresSafeArea()
            
//            CircleVisualization(radius: 400, values: analysisVM.visualizationValues)
            
            
            visualizationView
            
            // Song data
            if (playerVM.currentTrack != nil) {
                VStack {
                    Text(playerVM.currentTrack!.name)
                        .foregroundColor(.white)
                        .font(Font.custom("DMSerifDisplay-Regular", size: 60))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .lineSpacing(0)
                    
                    Text(playerVM.currentTrack!.artists[0].name)
                        .foregroundColor(.white)
                        .font(Font.custom("Poppins-Italic", size: 20))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    
                    Button ("Save") {
                        visualizationView.takeScreenshot()
                    }

                }
            }
            
        }
        .ignoresSafeArea()
        .onAppear{
            
            if (playerVM.currentTrack != nil) {
                playerVM.playCurrentTrack()
//                analysisVM.setupTimer()
//                counterOn = true
            }
           
        }
        .padding()
//        .onReceive(analysisVM.timer) { time in
//
//            // update visualization data
//            if(counterOn) {
//                self.counter += 0.01
//                let roundedcounter = round(counter*100)/100
//                if analysisVM.checkBeats(time:roundedcounter) {
//                    colorToggle.toggle()
//                }
//
//            }
//
//        }
        
    }
}

struct Animation_Previews: PreviewProvider {
    static var previews: some View {
        VisualizationView()
    }
}

class ImageSaver :NSObject {
    func writeImage(image:UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("saved")
    }
}


