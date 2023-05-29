//
//  ArtifyApp.swift
//  Artify
//
//  Created by Marieke Schmitz on 12.05.23.
//

import SwiftUI

@main
struct ArtifyApp: App {
    let persistenceController = PersistenceController.shared
    var network = Network()
    
    private let loginViewModel:LoginViewModel = LoginViewModel()
    private let musicLibraryViewModel:MusicLibraryViewModel = MusicLibraryViewModel()
    private let playerViewModel: PlayerViewModel = PlayerViewModel()
    

    var body: some Scene {
        WindowGroup {
            PlayView(loginVM:loginViewModel, musicLibraryVM: musicLibraryViewModel, playerVM: playerViewModel)
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
