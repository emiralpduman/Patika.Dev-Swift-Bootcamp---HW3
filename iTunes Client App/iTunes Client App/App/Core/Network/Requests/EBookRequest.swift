//
//  EBookRequest.swift
//  iTunes Client App
//
//  Created by Emiralp Duman on 10.10.2022.
//

import Foundation

struct EBookRequest: DataRequest {
    
    var searchText: String
    
    var baseURL: String {
        "https://itunes.apple.com"
    }
    
    var url: String {
        "/search"
    }
    
    var queryItems: [String : String] {
        ["term": searchText,
         "media" : "ebook"]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    init(searchText: String = "Apple") {
        self.searchText = searchText
    }
    
    func decode(_ data: Data) throws -> EBookResponse {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(EBookResponse.self, from: data)
        return response
    }
}
