//
//  PlayView.swift
//  Artify
//
//  Created by Marieke Schmitz on 22.05.23.
//

import Foundation
import SwiftUI

struct PlayView: View {
    
    @State var path = NavigationPath()
    @StateObject var loginVM: LoginViewModel = LoginViewModel.shared
    @StateObject var musicLibraryVM: MusicLibraryViewModel = MusicLibraryViewModel.shared
    @StateObject var playerVM: PlayerViewModel = PlayerViewModel.shared
    
//    init(_ loginViewModel:LoginViewModel, _ musicLibraryViewModel:MusicLibraryViewModel, _ playerViewModel:PlayerViewModel) {
//        self.loginVM = loginViewModel
//        self.musicLibraryVM = musicLibraryViewModel
//        self.playerVM = playerViewModel
//    }
    
    var body: some View{
        
        NavigationStack(path: $path) {
            
            if !loginVM.loginState.loggedIn {
                LoginView(path: $path, loginVM: loginVM).background(Color.darkGrayBG)
                
            } else {
                
                ZStack {
                    Color.yellow
                }
                VStack {
                    HStack {
                        NavigationLink(value: Route.musicLibrary) {
                            Text("Music Library")
                        }
                        NavigationLink(value: Route.settings) {
                            Text("Settings")
                        }
                    }
                }
                .navigationTitle("Player").navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .musicLibrary:
                        MusicLibraryView(musicLibraryVM: musicLibraryVM, path: $path)
                    case .settings:
                        SettingsView()
                    }
                }
                
                Spacer()

                
                HStack {
                    
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
//                        Button("Play specific song") {
//                            playerVM.playTrack("id: String")
//                        }
                    }
        
                    Button("Next") {
                        playerVM.playNextTrack()
                    }
                }
                
                
                
            }
        }.padding(.all).background(Color.darkGrayBG)
    }
}


struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}

