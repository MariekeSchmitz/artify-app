//
//  ArtistAlbums.swift
//  Artify
//
//  Created by Marieke Schmitz on 26.05.23.
//

import Foundation

struct ArtistAlbums: Decodable, Hashable {
    var items: Array<AlbumItem>? = []
}

struct AlbumItem: Decodable, Identifiable, Hashable {
    let id = UUID()
    let albumType: String?
    let name: String?
//    let releaseDate: String?
    let artists: [Artist]?
    let images: [AlbumImage]?
    let externalUrls: ExternalUrls?
    let totalTracks: Int?

    enum CodingKeys: String, CodingKey {
        case artists, images, name
        case albumType = "album_type"
//        case releaseDate = "release_date"
        case externalUrls = "external_urls"
        case totalTracks = "total_tracks"
    }
}

struct ExternalUrls: Decodable, Hashable {
    let spotify: String?
}

struct Artist: Decodable, Hashable {
    let name, type: String?
}

struct AlbumImage: Decodable, Hashable {
    let height: Int?
    let url: String?
    let width: Int?
}
