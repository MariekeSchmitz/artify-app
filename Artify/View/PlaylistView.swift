//
//  PlaylistView.swift
//  Artify
//
//  Created by Marieke Schmitz on 11.06.23.
//

import SwiftUI

struct PlaylistView: View {
    
    @StateObject var playlistViewmodel = PlaylistViewModel()
    var playerVM = PlayerViewModel.shared
    var playlistID : String
    var playlistName : String
    var imageURL : String
    @Binding var path : NavigationPath
    
    var body: some View {
       
        VStack {
           
            ScrollView{
                ImageView(url: imageURL)
                    .overlay(alignment: .bottomLeading, content: {
                        Text(playlistName)
                            .bold()
                            .foregroundColor(Color.white)
                            .padding()
                    })
                
                LazyVStack(alignment: .leading, spacing: 20) {
                    ForEach(playlistViewmodel.playlist.items, id: \.self) { track in
                        TrackCellView(track: track.track, path: $path)
                    }
                }
            }
        }
        .onAppear() {
            playlistViewmodel.getAllTracksInPlaylist(playlistId: playlistID)
        }.background(Color.darkGrayBG)
        
    }
}



struct ImageView: View {
    
    var url:String
    
    var body: some View {
    
        AsyncImage(url: URL(string: url)) {
            image in image.resizable()
        }
        placeholder: { Color.gray }
            .scaledToFill()
            .frame(width:200, height: 200)
            .overlay(content: {
                Rectangle().foregroundColor(Color.black).opacity(0.5).frame(width: 200, height: 200)

            })
            
        
    }
}


//struct PlaylistView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistView()
//    }
//}


