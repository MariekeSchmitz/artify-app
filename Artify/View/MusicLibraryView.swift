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
        VStack{
            
            Text("MusicLibraryView").font(.largeTitle)
            
            Text("Playlists").font(.title)
            PlaylistsView(playlists: musicLibraryVM.playlistLibrary.items, path:$path)
            
            Text("Tracks").font(.title)
            TrackView(savedTrackObjects: musicLibraryVM.favoriteTracks.items, path: $path)
            
        }.onAppear(){
            musicLibraryVM.getFavouriteTracks()
            musicLibraryVM.getUsersPlaylists()
        }.border(.green).padding(0)
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
    
    var body: some View {
        
        NavigationLink(destination: PlaylistView(playlistID: playlist.id, playlistName: playlist.name, imageURL: playlist.images[0].url, path:$path)) {
            AsyncImage(url: URL(string: playlist.images[0].url)) {
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
