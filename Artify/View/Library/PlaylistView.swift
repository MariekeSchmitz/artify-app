//
//  PlaylistView.swift
//  Artify
//
//  Created by Marieke Schmitz on 11.06.23.
//

import SwiftUI

struct PlaylistView: View {
    
    @StateObject var playlistViewmodel = PlaylistViewModel()
    @Binding var musicLibraryViewOn:Bool

    var playerVM = PlayerViewModel.shared
    var playlistID : String
    var playlistName : String
    var imageURL : String
    
    var body: some View {
       
        VStack {
            
            ImageView(url: imageURL, name: playlistName).ignoresSafeArea()
            ScrollView{
                LazyVStack(alignment: .leading, spacing: 5) {
                    ForEach(playlistViewmodel.playlist.items, id: \.self) { track in
                        TrackCellView(musicLibraryViewOn: $musicLibraryViewOn, track: track.track)
                    }
                }
            }.ignoresSafeArea().padding(0)
        }
        .onAppear() {
            playlistViewmodel.getAllTracksInPlaylist(playlistId: playlistID)
        }.background(Color.black).ignoresSafeArea()
        
    }
}



struct ImageView: View {
    
    var url:String
    var name: String
    
    var body: some View {

        GeometryReader { geo in
            AsyncImage(url: URL(string: url)) {
                image in image.resizable().aspectRatio(contentMode: .fill).ignoresSafeArea()
            }
            placeholder: { Color.gray }
                .frame(width:geo.size.width, height: geo.size.width).ignoresSafeArea()
                .overlay(alignment: .bottomLeading) {
                    Rectangle().fill(
                        LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]),
                                       startPoint: .top,
                                       endPoint: .bottom)).frame(width:geo.size.width, height: geo.size.width).ignoresSafeArea()
                        .overlay(alignment: .bottomLeading) {
                            Text(name)
                                .font(Font.custom("DMSerifDisplay-Regular", size: 55))
                                .font(Font.body.leading(.tight))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .ignoresSafeArea()
                                .lineSpacing(0)

                        }
                    
                }.ignoresSafeArea()
        }
  
    }
}


//struct PlaylistView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistView()
//    }
//}


