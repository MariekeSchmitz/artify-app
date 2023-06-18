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
//    var network = Network()
    

    
    var body: some Scene {
        WindowGroup {
            PlayView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
