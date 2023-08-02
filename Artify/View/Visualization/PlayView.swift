//
//  Animation.swift
//  Artify
//
//  Created by Marieke Schmitz on 19.06.23.
//

import SwiftUI
import PhotosUI

struct PlayView:View {
    
    @StateObject var musicLibraryVM: MusicLibraryViewModel = MusicLibraryViewModel.shared
    @StateObject var analysisVM: MusicAnalysisViewModel = MusicAnalysisViewModel.shared
    @StateObject var playerVM: PlayerViewModel = PlayerViewModel.shared
    
    @Binding var musicLibraryViewOn:Bool
    @Binding var settingViewOn:Bool
    
        
    @State var visualizationView = VisualizationView()
    
    

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            visualizationView
            
            VStack{
                HStack{
                    Button {
                        withAnimation {
                            musicLibraryViewOn.toggle()
                        }
                    } label: {
                        Image("playlist")
                    }
                    
                    Spacer()
                    
                    Button {
                        visualizationView.takeScreenshot()
                    } label: {
                        Image("screenshot")
                    }
                    
//                    Button("Settings") {
//                        withAnimation {
//                            settingViewOn.toggle()
//                        }
//                    }
                }.padding()
                
                
                Spacer()
                
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
                        
                    }
                }
                
                HStack {
                    VStack {
                        
                        if (playerVM.isPlayling) {
                            Button {
                                playerVM.pauseTrack()
                                print("Track to be paused")
                            } label: {
                                Image("pause")
                            }
                        } else {
                            Button {
                                playerVM.resumeTrack()
                                print("Track to be played")

                            } label: {
                                Image("play")
                            }
                        }

                        
                        if (playerVM.currentTrack != nil) {
                            Slider(value: $playerVM.currentTIme, in: 0...Double(playerVM.currentTrack!.duration_ms)/1000.0) { editingChange in
                                print(editingChange)
                                if (editingChange) {
                                    playerVM.currentTimeAllowsChange = false
                                } else {
                                    if (!playerVM.currentTimeAllowsChange) {
                                        print("CURRENT TIME SLIDER END: ",playerVM.currentTIme)
                                        print(playerVM.currentTrack!.duration_ms)
                                        playerVM.seekToPositionInTrack(time_s: playerVM.currentTIme)
                                    }
                                }
                            }
                                
                        }
                        
                        
                        Text("\(playerVM.currentTIme)")
                            .foregroundColor(.white)
                            .font(Font.custom("Poppins-Italic", size: 20))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        
                    }
                }
            }.padding()
        }.onAppear{
            if (playerVM.currentTrack != nil) {
                playerVM.playCurrentTrack()
            }

           
        }
        .ignoresSafeArea()
    }
    
    private func sliderEditingChanged(editingStarted: Bool) {
        if editingStarted {
            // timeraktualisierung pausieren
        } else {
            
        }
    }
    
    
}









