//
//  MusicLibraryView.swift
//  Artify
//
//  Created by Marieke Schmitz on 27.05.23.
//

import SwiftUI

struct MusicLibraryView: View {
    
    @StateObject var musicLibraryVM : MusicLibraryViewModel
    let playerVM = PlayerViewModel.shared
    
    @Binding var path: NavigationPath

    var body: some View {
        
        Color.darkGrayBG
            .ignoresSafeArea()
            .overlay(
                VStack{
                    
                    Text("Tracks")
                        .font(Font.custom("DMSerifDisplay-Regular", size: 70))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(Color.white)
                        
                    
                    Text("Playlists")
                        .font(Font.custom("DMSerifDisplay-Regular", size: 30))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.white)
                    PlaylistsView(playlists: musicLibraryVM.playlistLibrary.items, path:$path)
                    
                    Text("Tracks")
                        .font(Font.custom("DMSerifDisplay-Regular", size: 30))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.white)
                    TrackView(savedTrackObjects: musicLibraryVM.favoriteTracks.items, path: $path)
                    
                }.onAppear(){
                    musicLibraryVM.getFavouriteTracks()
                    musicLibraryVM.getUsersPlaylists()
                }
                
            )
    }
}

struct PlaylistsView: View {
    
    var playlists:[SimplifiedPlaylistObject]
    @Binding var path:NavigationPath
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(playlists, id: \.self) { playlist in
                    PlaylistCellView(playlist: playlist, path:$path)
                }
            }
        }
    }
}

struct PlaylistCellView: View {
    
    var playlist: SimplifiedPlaylistObject
    @Binding var path:NavigationPath
    
    var imageURL : String {
        if (playlist.images.count == 0) {
           return "https://en.wikipedia.org/wiki/Image#/media/File:Image_created_with_a_mobile_phone.png"
        } else {
            return playlist.images[0].url
        }
    }
    
    
    var body: some View {
                
        NavigationLink(destination: PlaylistView(playlistID: playlist.id, playlistName: playlist.name, imageURL: imageURL, path:$path)) {
            AsyncImage(url: URL(string: imageURL)) {
                image in image.resizable()
            }
            placeholder: { Color.gray }
                .frame(width: 200, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 20).foregroundColor(Color.black).opacity(0.5).frame(width: 200, height: 200)

                })
                .overlay(alignment: .bottomLeading, content: {
                    Text(playlist.name)
                        .bold()
                        .foregroundColor(Color.white)
                        .padding()
                    
                })

        }

    }
}





struct MusicLibraryView_Previews: PreviewProvider {

    static var previews: some View {
        MusicLibraryView(musicLibraryVM: MusicLibraryViewModel.shared, path:PlayView(loginVM: LoginViewModel.shared, musicLibraryVM:MusicLibraryViewModel.shared, playerVM: PlayerViewModel.shared).$path)
    }
}
