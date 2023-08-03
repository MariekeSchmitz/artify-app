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
    
    var visualizationTypes:[VisualizationType] = VisualizationType.allCases.map { $0 }
    

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
                        
                        if (playerVM.currentTrack != nil) {
                            
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
                            
                            Slider(value: $playerVM.currentTIme, in: 0...Double(playerVM.currentTrack!.duration_ms)/1000.0) { editingChange in
                                print(editingChange)
                                if (editingChange) {
                                    playerVM.timeOnHold = false
                                } else {
                                    if (!playerVM.timeOnHold) {
                                        print("CURRENT TIME SLIDER END: ",playerVM.currentTIme)
                                        print(playerVM.currentTrack!.duration_ms)
                                        playerVM.seekToPositionInTrack()
                                    }
                                }
                            }.tint(Color.white).padding(.horizontal,30)
                            
                            Picker("Selection", selection: $analysisVM.visualizationType) {
                                            ForEach(visualizationTypes, id: \.self) { i in
                                                Text(i.description)
//                                                    .rotationEffect(Angle(degrees: 90))
                                            }
                            }.pickerStyle(.menu)
                                .onChange(of: analysisVM.visualizationType) { change in
                                    playerVM.songForwarded = true
                                    playerVM.offset = playerVM.currentTIme
                                }
//                                .rotationEffect(Angle(degrees: -90))
//                                .frame(maxHeight: 100)
//                                .clipped()
                                
                        } else {
                            Text("Select a song")
                                .foregroundColor(.white)
                                .font(Font.custom("DMSerifDisplay-Regular", size: 40))
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                                .lineSpacing(0)
                        }
                        
                        
                    }
                }
            }.padding(20).padding(.vertical, 50)
        }.onAppear{
            if (playerVM.currentTrack != nil) {
                playerVM.playCurrentTrack()
            }
            let thumbImage = UIImage(systemName: "circle")
            UISlider.appearance().setThumbImage(thumbImage, for: .normal)
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









