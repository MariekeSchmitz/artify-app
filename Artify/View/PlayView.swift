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
    @ObservedObject var loginVM: LoginViewModel
    @ObservedObject var musicLibraryVM: MusicLibraryViewModel
    @ObservedObject var playerVM: PlayerViewModel
    
//    init(_ loginViewModel:LoginViewModel, _ musicLibraryViewModel:MusicLibraryViewModel, _ playerViewModel:PlayerViewModel) {
//        self.loginVM = loginViewModel
//        self.musicLibraryVM = musicLibraryViewModel
//        self.playerVM = playerViewModel
//    }
    
    var body: some View{
        
        NavigationStack(path: $path) {
            
            if !loginVM.loginState.loggedIn {
                LoginView(path: $path, loginVM: loginVM)
                
            } else {
                
                VStack {
                    HStack {
                        NavigationLink(value: Route.musicLibrary) {
                            Text("Music Library")
                        }
                        NavigationLink(value: Route.settings) {
                            Text("Settings")
                        }
                    } 
                    Button("Play") {
                        PlayerViewModel.shared.startPlayback(track: musicLibraryVM.track)
                    }
                }
                .navigationTitle("Player").navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .musicLibrary:
                        MusicLibraryView(musicLibraryVM: musicLibraryVM, path: $path)
                    case .settings:
                        SettingsView()
    //                case .login:
    //                    LoginView(path: $path)
    //                case .login:
                        
                    }
                }
            }
        }
    }
}


//struct PlayView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayView()
//    }
//}

