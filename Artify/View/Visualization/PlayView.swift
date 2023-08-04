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
    
    var visualizationTypes:[VisualizationType] = VisualizationType.allCases.map { $0 }
    var visualizationModifiers:[VisualizationModifier] = VisualizationModifier.allCases.map { $0 }


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
    //                                .onChange(of: analysisVM.visualizationType) { change in
    //                                    playerVM.songForwarded = true
    //                                }
                            }
                            
                            
                            
                            
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
//        .task {
//            try? await Task.sleep(nanoseconds: 4_000_000_000)
//            if (playerVM.currentTrack != nil) {
//                playerVM.playCurrentTrack()
//            }
//        }
    }
    
    private func delayPlaying() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        if (playerVM.currentTrack != nil) {
            playerVM.playCurrentTrack()
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
    
    
//    private func createSplittedStrings(title:String) -> [String] {
//
//        let words = title.components(separatedBy: " ")
//        let numWords = words.count
//
//        var lines = [String](repeating: "", count: numWords)
//
//        longTitle = title.count > 30
//        let maxLengthPerLine = longTitle ? 16 : 11
//
//        var lineCount = 0
//
//        for word in words {
//
//            var combinedWord = word + " " + lines[lineCount]
//            if combinedWord.count >= maxLengthPerLine {
//                lineCount += 1
//            }
//
//            lines[lineCount] += (word + " ")
//        }
//
//        return lines
//
//    }
//
    
}









