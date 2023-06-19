//
//  PlayView.swift
//  Artify
//
//  Created by Marieke Schmitz on 22.05.23.
//

import Foundation
import SwiftUI

struct PlayView: View {
    
    @StateObject var loginVM: LoginViewModel = LoginViewModel.shared
    @StateObject var musicLibraryVM: MusicLibraryViewModel = MusicLibraryViewModel.shared
    
    @State var musicLibraryViewOn = false
    @State var settingViewOn = false
    
    var body: some View{
        
        ZStack {
            
            if musicLibraryViewOn {
                
                Color.black.opacity(0.5).ignoresSafeArea()
                
                MusicLibraryView(musicLibraryViewOn: $musicLibraryViewOn).transition(.move(edge: .trailing))
              
//                GeometryReader{ geometry in
//                    
//                    MusicLibraryView(musicLibraryViewOn: $musicLibraryViewOn)
//                        .frame(width: geometry.size.width * 0.9, alignment: .center)
//
//                }.transition(.move(edge: .trailing))
                
            } else if settingViewOn {
                SettingsView(settingsViewOn: $settingViewOn).transition(.move(edge: .trailing))
            } else {
                MainView(musicLibraryViewOn: $musicLibraryViewOn, settingViewOn: $settingViewOn)
            }
        }
    }
}

struct MainView:View {
    
    @StateObject var playerVM: PlayerViewModel = PlayerViewModel.shared
    @Binding var musicLibraryViewOn:Bool
    @Binding var settingViewOn:Bool
    @State var counter: Int = 0

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VisualizationView()
            
            VStack{
                HStack{
                    Button("MusicLibrary") {
                        withAnimation {
                            musicLibraryViewOn.toggle()
                        }
                        
                    }
                    
                    Button("Settings") {
                        withAnimation {
                            settingViewOn.toggle()
                        }
                    }
                }
                
                Spacer()
                
                HStack {
                    
                    Text("\(counter)").foregroundColor(.white)
                    Button("Previous") {
                        playerVM.playPreviousTrack()
                    }
                    VStack {
                        Button("Pause") {
                            playerVM.pauseTrack()
                        }
                        Button("Play") {
                            playerVM.resumeTrack()
                        }
                        
                    }
                    Button("Next") {
                        playerVM.playNextTrack()
                    }
                }
            }
        }.onReceive(playerVM.timer) { time in
            self.counter += 1
        }
    }
}




struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}

