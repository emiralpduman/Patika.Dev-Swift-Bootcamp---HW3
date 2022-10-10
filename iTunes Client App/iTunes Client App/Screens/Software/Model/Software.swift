//
//  Software.swift
//  iTunes Client App
//
//  Created by Emiralp Duman on 10.10.2022.
//

import Foundation

struct Software: Decodable {
    let artwork: URL?
    let trackName: String?

    let primaryGenreName: String?
    let releaseDate: String?
    let artistName: String?
}

