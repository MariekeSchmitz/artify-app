//
//  TrackView.swift
//  Artify
//
//  Created by Marieke Schmitz on 11.06.23.
//

import SwiftUI

struct TrackView: View {
    
    @Binding var musicLibraryViewOn:Bool
    @Binding var loadingIndicatorOn: Bool

    var savedTrackObjects:[SavedTrackObject]
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                ForEach(savedTrackObjects, id: \.self) { savedTrackObject in
                    TrackCellView(musicLibraryViewOn:$musicLibraryViewOn, loadingIndicatorOn: $loadingIndicatorOn, track: savedTrackObject.track)
                }
            }
        }
       
    }
    
}

struct TrackCellView: View {
    
    @Binding var musicLibraryViewOn:Bool
    @Binding var loadingIndicatorOn: Bool
    
    var playerVM = PlayerViewModel.shared
    var audioAnalysis = MusicAnalysisViewModel.shared
    var track: Track
    
    var body: some View {
       
        ZStack (alignment: .leading) {
            Color.black
            HStack {
                
                Rectangle().fill(Color.white).frame(width: 1, height: 30, alignment: .leading).padding(.trailing,10)
                
                VStack (alignment: .leading){
                    Text(track.name).font(Font.custom("Poppins-Regular", size: 18)).foregroundColor(.white)
                    Text(getArtistString(artists:track.artists)).font(Font.custom("Poppins-Italic", size: 13)).foregroundColor(.white)
                }
            }
            .onTapGesture {
                playerVM.currentTrack = track
                loadingIndicatorOn = true
                Task {
                    await audioAnalysis.getTracksAudioAnalysis(id: track.id)
                    await audioAnalysis.getTracksAudioFeatures(id: track.id)
                    withAnimation {
                        musicLibraryViewOn.toggle()
                    }
                }

            }.padding()
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
