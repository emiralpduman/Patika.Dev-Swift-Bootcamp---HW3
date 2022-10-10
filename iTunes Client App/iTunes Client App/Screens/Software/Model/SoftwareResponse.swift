//
//  SoftwareResponse.swift
//  iTunes Client App
//
//  Created by Emiralp Duman on 10.10.2022.
//

import Foundation

struct SoftwareResponse: Decodable {
    let resultCount: Int?
    let results: [Software]?
}
