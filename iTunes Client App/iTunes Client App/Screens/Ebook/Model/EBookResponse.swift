//
//  EBookResponse.swift
//  iTunes Client App
//
//  Created by Emiralp Duman on 10.10.2022.
//

import Foundation

struct EBookResponse: Decodable {
    let resultCount: Int?
    let results: [EBook]?
}
