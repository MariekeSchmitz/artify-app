////
////  AlbumListView.swift
////  Artify
////
////  Created by Marieke Schmitz on 26.05.23.
////
//
//import SwiftUI
//
//struct AlbumListView: View {
//
//    // get shared data async from view model
//    @ObservedObject var viewModel: AlbumListViewModel
//
//    var body: some View {
//        NavigationView {
//            // get data
//            let albumList = viewModel.getAlbumList()
//            let albumImageUrls = viewModel.getAlbumImageUrls()
//            // list for albums
//            List(Array(zip(albumList, albumImageUrls)), id: \.0) { album, albumImage in
//                HStack {
//                    // get image with album image url
//                    if let imageData = try? Data(contentsOf: albumImage),
//                       let image = UIImage(data: imageData) {
//                        Image(uiImage: image)
//                            .resizable()
//                            .cornerRadius(150/2)
//                            .frame(width: 150, height: 150)
//                            .clipped()
//                    }
//                    VStack(alignment: .leading, spacing: 10) {
//                        if let name = album.name,
//                           let albumType = album.albumType,
////                           let releaseDate = album.releaseDate,
//                           let spotifyUrl = album.externalUrls?.spotify,
//                           let totalTracks = album.totalTracks {
//                            Text("Name: \(name)").font(.headline)
////                            Text("Release Date: \(releaseDate)").font(.subheadline)
//                            Text("Total Tracks: \(totalTracks)").font(.subheadline)
//                            Link("go to \(albumType)", destination: URL(string: spotifyUrl)!)
//                        }
//                    }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
//                }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
//            }.onAppear {
//                // fire the data transactions
//                viewModel.getData()
//            }.navigationBarTitle("Alben")
//        }
//    }
//}
//
//struct AlbumListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlbumListView(viewModel: AlbumListViewModel())
//    }
//}
