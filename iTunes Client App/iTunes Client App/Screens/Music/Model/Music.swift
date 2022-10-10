//
//  Music.swift
//  iTunes Client App
//
//  Created by Emiralp Duman on 10.10.2022.
//

import Foundation

struct Music: Decodable {
    let artistName, collectionName: String?
    let artworkUrl100: URL?
    let releaseDate: String?
    let primaryGenreName: String?
    let trackName: String?
}
