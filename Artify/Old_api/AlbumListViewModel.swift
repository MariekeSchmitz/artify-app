//
//  AlbumListViewModel.swift
//  Artify
//
//  Created by Marieke Schmitz on 26.05.23.

import Foundation
import Combine

class AlbumListViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    @Published private var albumList: Array<AlbumItem> = []
    @Published private var albumImageUrls: Array<URL> = []
        
        init() {
            // set artist id for request
            DataProvider.shared.getArtistsAlbums(id: "0gadJ2b9A4SKsB1RFkBb66")
        }
        
        func getData() {
            // subscribe
            DataProvider.shared.artistAlbumsSubject
                .sink(receiveValue: { [weak self] items in
                    guard let self = self else { return }
                    // set data to albumList object
                    self.albumList = items
                    self.setAlbumImageUrls(with: items)
                }).store(in: &cancellables)
        }
        
        // return albumList to view
        func getAlbumList() -> Array<AlbumItem> {
            return albumList
        }
        
        // some collection type transactions
        private func setAlbumImageUrls(with albums: [AlbumItem]) {
            for album in albums {
                if let firstImageUrl = album.images?.first?.url,
                   let imageUrl = URL(string: firstImageUrl) {
                    albumImageUrls.append(imageUrl)
                }
            }
        }
        
        // return albumImageList to view
        func getAlbumImageUrls() -> Array<URL> {
            return albumImageUrls
        }
    }
