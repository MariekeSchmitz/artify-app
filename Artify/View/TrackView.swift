//
//  TrackView.swift
//  Artify
//
//  Created by Marieke Schmitz on 11.06.23.
//

import SwiftUI

struct TrackView: View {
    
    var savedTrackObjects:[SavedTrackObject]
    @Binding var path:NavigationPath
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(savedTrackObjects, id: \.self) { savedTrackObject in
                    TrackCellView(track: savedTrackObject.track, path: $path)
                }
            }
        }
        .frame(height: 250)
    }
    
}

struct TrackCellView: View {
    
    var playerVM = PlayerViewModel.shared
    var musicLibraryVM = MusicLibraryViewModel.shared
    var track: Track
    @Binding var path:NavigationPath
    
    var body: some View {
        
        VStack (alignment: .leading){
            Text(track.name).font(.title3).foregroundColor(Color.white)
            Text(getArtistString(artists:track.artists)).font(.subheadline).foregroundColor(Color.white)
        } .onTapGesture {
            playerVM.playTrack(id: track.uri)
            musicLibraryVM.track = track
            print(musicLibraryVM.track.name)
            print(track.name)
            path = NavigationPath()
        }
        
    }
    
    func getArtistString(artists:[Artist]) -> String {
        
        var artistString = ""
        
        for i in 0...(artists.count - 1) {
            if i == (artists.count - 1) {
                artistString += artists[i].name
            } else {
                artistString += "\(artists[i].name), "
            }
        }
        
        return artistString
    }
}
