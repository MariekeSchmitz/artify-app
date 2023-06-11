////
////  Data Providing.swift
////  Artify
////
////  Created by Marieke Schmitz on 26.05.23.
////
//
//import Foundation
//import Combine
//
//class DataProvider {
//
//    static let shared = DataProvider()
//
//    private var cancellable = Set<AnyCancellable>()
//
//    var artistAlbumsSubject = PassthroughSubject<[AlbumItem], Never>()
//
//    private init() {
//
//    }
//
//

//}
//
//extension DataProvider {
//    func getArtistsAlbums(id:String) {
//        let url = URL(string: "https://api.spotify.com/v1/artists/\(id)/albums")
//        let model = APIManager<ArtistAlbums>.RequestModel(url:url, method: .get)
//
//        APIManager.shared.request(with: model)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print(error)
//                }
//            }, receiveValue: { albums in
//                guard let items = albums.items else { return }
//
//                // publish
//                self.artistAlbumsSubject.send(items)
//            }).store(in: &self.cancellable)
//    }
//}
