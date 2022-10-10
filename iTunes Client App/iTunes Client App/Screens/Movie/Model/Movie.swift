//
//  Movie.swift
//  iTunes Client App
//
//  Created by Emiralp Duman on 7.10.2022.
//

import Foundation

struct Movie: Decodable {
    let director, title: String?
    let artwork: URL?
    let releaseDate: String?
    let contentAdvisoryRating: String?
    let longDescription: String?

    enum CodingKeys: String, CodingKey {
        case director = "artistName", title = "trackName"
        case artwork = "artworkUrl100"
        case releaseDate, contentAdvisoryRating, longDescription
    }
}
