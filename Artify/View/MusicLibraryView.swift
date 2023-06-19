//
//  MusicLibraryView.swift
//  Artify
//
//  Created by Marieke Schmitz on 27.05.23.
//

import SwiftUI

struct MusicLibraryView: View {
    
    @StateObject var musicLibraryVM : MusicLibraryViewModel = MusicLibraryViewModel.shared
    let playerVM = PlayerViewModel.shared
    @Binding var musicLibraryViewOn:Bool
    
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.darkGrayBG.ignoresSafeArea()
                VStack(spacing:0){
                    HStack{
                        Button("Zurück") {
                            withAnimation {
                                musicLibraryViewOn.toggle()
                            }
                        }
                        Text("Tracks")
                            .font(Font.custom("DMSerifDisplay-Regular", size: 80))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .foregroundColor(Color.white)
                            .padding(.top, 50)
                            .padding(.trailing, 20)
                    }
                    
                    Text("Deine Playlists")
                        .font(Font.custom("DMSerifDisplay-Regular", size: 32))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.white)
                        .padding(.top, 35)
                        .padding(.bottom, 15)
                        
                    PlaylistsView(playlists: musicLibraryVM.playlistLibrary.items, musicLibraryViewOn: $musicLibraryViewOn).padding(0)
                    
                    
                    Text("Deine Top-Tracks")
                        .font(Font.custom("DMSerifDisplay-Regular", size: 32))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.white)
                        .padding(.top, 35)
                        .padding(.bottom, 15)
                    
                    TrackView(musicLibraryViewOn: $musicLibraryViewOn, savedTrackObjects: musicLibraryVM.favoriteTracks.items)
                }
                .onAppear(){
                    musicLibraryVM.getFavouriteTracks()
                    musicLibraryVM.getUsersPlaylists()
                }.padding(.leading, 20)
                
            }
        }
    }
}

struct PlaylistsView: View {
    
    var playlists:[SimplifiedPlaylistObject]
    @Binding var musicLibraryViewOn:Bool
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(playlists, id: \.self) { playlist in
                    PlaylistCellView(playlist: playlist, musicLibraryViewOn: $musicLibraryViewOn)
                }
            }
        }.padding(0).frame(height: 200)

        
    }
}

struct PlaylistCellView: View {
    
    var playlist: SimplifiedPlaylistObject
    @Binding var musicLibraryViewOn:Bool
    
    var imageURL : String {
        if (playlist.images.count == 0) {
           return "https://en.wikipedia.org/wiki/Image#/media/File:Image_created_with_a_mobile_phone.png"
        } else {
            return playlist.images[0].url
        }
    }
    
    
    var body: some View {
        
            NavigationLink(destination: PlaylistView(musicLibraryViewOn: $musicLibraryViewOn, playlistID: playlist.id, playlistName: playlist.name, imageURL: imageURL)) {
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
                            .font(Font.custom("Poppins-Regular", size: 18)).foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    })
            }
    }
}


//struct MusicLibraryView_Previews: PreviewProvider {
//
//    static var previews: some View {
////        MusicLibraryView(musicLibraryVM: MusicLibraryViewModel.shared, path:PlayView(loginVM: LoginViewModel.shared, musicLibraryVM:MusicLibraryViewModel.shared, playerVM: PlayerViewModel.shared).$path)
//    }
//}
