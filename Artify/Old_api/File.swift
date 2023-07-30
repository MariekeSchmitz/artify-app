//
//  File.swift
//  Artify
//
//  Created by Marieke Schmitz on 01.06.23.
//

import Foundation

struct Food: Identifiable, Decodable {
    var id: Int
    var uid: String
    var dish: String
    var description: String
    var ingredient: String
    var measurement: String
}
