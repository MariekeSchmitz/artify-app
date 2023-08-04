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
    
    @State var longTitle:Bool = false
    @State var showInfo:Bool = true
    @State var screenshotSavingSuccess:Bool = false
    @State var instructionsTimePassed:Bool = false
    
    var visualizationTypes:[VisualizationType] = VisualizationType.allCases.map { $0 }
    var visualizationModifiers:[VisualizationModifier] = VisualizationModifier.allCases.map { $0 }
    var audioFeatureColors:[AudioFeatureColors] = AudioFeatureColors.allCases.map { $0 }


    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            visualizationView
            
            VStack {
                Button{
                    withAnimation {
                        showInfo.toggle()
                    }
                }label: {
                    Image("up").rotationEffect(.degrees(showInfo ? 0 : 180))
                }.padding(.top, 50)
                Spacer()
            }
            

            
            if (showInfo) {
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
                            screenshotSavingSuccess = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {screenshotSavingSuccess = false}
                        } label: {
                            Image(screenshotSavingSuccess ? "check" : "screenshot")
                        }
                        
                    }.padding()
                    
                    
                    Spacer()
                    
                    // Song data
                    if (playerVM.currentTrack != nil) {
                        VStack {
                            
                            TitleView(title: playerVM.currentTrack!.name)
                            
                            Text(playerVM.currentTrack!.artists[0].name)
                                .foregroundColor(.white)
                                .font(Font.custom("Poppins-Italic", size: 20))
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                            
                        }
                    }
                    
                    VStack {
                        
                        if (playerVM.currentTrack != nil) {
                            

                            HStack (spacing:20){
                                
                                if (playerVM.isPlayling) {
                                    Button {
                                        playerVM.pauseTrack()
                                    } label: {
                                        Image("pause")
                                    }
                                } else {
                                    Button {
                                        playerVM.resumeTrack()
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
                                            playerVM.seekToPositionInTrack()
                                        }
                                    }
                                }.tint(Color.white).padding(.trailing,30)
                            }.padding(.leading, 20)
                            
                            
                            HStack {
                                Picker("Selection", selection: $analysisVM.visualizationType) {
                                    ForEach(visualizationTypes, id: \.self) { i in
                                        Text(i.description)
                                    }
                                }
                                .pickerStyle(.menu)
                                    .accentColor(.white)
                                    .font(Font.custom("Poppins-Regular", size: 15))
                                    .onChange(of: analysisVM.visualizationType) { change in
                                        playerVM.songForwarded = true
                                        playerVM.offset = playerVM.currentTIme
                                    }

                                    
                                Picker("Selection", selection: $analysisVM.visualizationModifier) {
                                    ForEach(visualizationModifiers, id: \.self) { i in
                                        Text(i.description)
                                    }
                                }.pickerStyle(.menu)
                                    .accentColor(.white)
                                    .font(Font.custom("Poppins-Regular", size: 15))

                                Picker("Selection", selection: $analysisVM.audioFeatureColor) {
                                    ForEach(audioFeatureColors, id: \.self) { i in
                                        Text(i.description)
                                    }
                                }.pickerStyle(.menu)
                                    .accentColor(.white)
                                    .font(Font.custom("Poppins-Regular", size: 15))
                                    .onChange(of: analysisVM.audioFeatureColor) { change in
                                        playerVM.songForwarded = true
                                        playerVM.offset = playerVM.currentTIme
                                        print(analysisVM.audioFeatureColor)
                                    }
                            }
      
                        } else {
                            VStack {
                                
                                if (instructionsTimePassed) {
                                    Image("export")
                                } else {
                                    Image("choose")
                                }
                                Spacer()
                            }.task(delayInstruction)

                        }
  
                    }
                }.padding(20).padding(.vertical, 50)
            }
            
            
        }.onAppear{
            if (playerVM.currentTrack != nil) {
                playerVM.playCurrentTrack()
            }
            let thumbImage = UIImage(systemName: "circle")
            UISlider.appearance().setThumbImage(thumbImage, for: .normal)
            
        }
        .ignoresSafeArea()

    }
    
    private func delayInstruction() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        withAnimation {
            instructionsTimePassed = true
        }

    }
    

    struct TitleView: View {
        
        var title:String
        var longTitle: Bool = false
        var lines:[String] = []
        
        init(title:String) {
            self.title = title
            let words = title.components(separatedBy:" ")
            let numWords = words.count
            
            lines = [String](repeating: "", count: numWords)
            longTitle = title.count > 30
            
            let maxLengthPerLine = longTitle ? 20 : 11
            
            var lineCount = 0
            
            for word in words {
                
                let combinedWord = word + " " + lines[lineCount]
                if combinedWord.count >= maxLengthPerLine {
                    lineCount += 1
                }
                
                lines[lineCount] += (word + " ")
            }
            
        }
        
        
        var body: some View {
            
            ForEach(lines, id: \.self) { line in
                
                if (line != "") {
                    Text(line)
                        .foregroundColor(.white)
                        .font(Font.custom("DMSerifDisplay-Regular", size: longTitle ? 40 : 55))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .trailing).frame(height:longTitle ? 41 : 52)
                }
                
            }
            
        }
        
    }
    

    
}


