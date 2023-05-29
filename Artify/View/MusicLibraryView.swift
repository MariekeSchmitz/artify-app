//
//  MusicLibraryView.swift
//  Artify
//
//  Created by Marieke Schmitz on 27.05.23.
//

import SwiftUI

struct MusicLibraryView: View {
    
    let musicLibraryVM : MusicLibraryViewModel
    @Binding var path: NavigationPath

    var body: some View {
        
        Text("Hello, this is the MusicLibraryView! :)")
        Button("Get Track") {
            musicLibraryVM.getTrackById()
//            path.removeLast()
        } .backgroundStyle(.blue)
        
        HStack {
            Button("Previous") {
                musicLibraryVM.playPreviousTrack()
            }
            
            VStack {
                Button("Pause") {
                    musicLibraryVM.pauseTrack()
                }
                Button("Play") {
                    musicLibraryVM.playTrack()
                }
            }
            
            Button("Next") {
                musicLibraryVM.playNextTrack()
            }
        }
        
        
    }
}
//
//struct MusicLibraryView_Previews: PreviewProvider {
//    static var previews: some View {
//        MusicLibraryView(musicLibraryViewModel: MusicLibraryViewModel())
//    }
//}
