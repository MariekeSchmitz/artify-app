//
//  PlayView.swift
//  Artify
//
//  Created by Marieke Schmitz on 22.05.23.
//

import Foundation
import SwiftUI

struct MainView: View {
    
    @StateObject var loginVM: LoginViewModel = LoginViewModel.shared
    @StateObject var musicLibraryVM: MusicLibraryViewModel = MusicLibraryViewModel.shared
    
    @State var musicLibraryViewOn = false
    @State var settingViewOn = false
    
    var body: some View{
        
        ZStack {
            
            if musicLibraryViewOn {
                
                Color.black.opacity(0.5).ignoresSafeArea()
                
                MusicLibraryView(musicLibraryViewOn: $musicLibraryViewOn).transition(.move(edge: .leading ))
              
//                GeometryReader{ geometry in
//                    
//                    MusicLibraryView(musicLibraryViewOn: $musicLibraryViewOn)
//                        .frame(width: geometry.size.width * 0.9, alignment: .center)
//
//                }.transition(.move(edge: .trailing))
                
            } else if settingViewOn {
                SettingsView(settingsViewOn: $settingViewOn).transition(.move(edge: .trailing))
            } else {
                PlayView(musicLibraryViewOn: $musicLibraryViewOn, settingViewOn: $settingViewOn)
            }
        }
    }
}



