//
//  EBoook.swift
//  iTunes Client App
//
//  Created by Emiralp Duman on 10.10.2022.
//

import Foundation

struct EBook: Decodable {
    let artworkUrl100: URL?
    let trackName: String?    
    let artistName: String?
    let genres: [String]?
    let eBookDescription: String?
    let releaseDate: String?

}
