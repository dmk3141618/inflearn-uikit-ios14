//
//  MovieVO.swift
//  MovieApp
//
//  Created by 이치훈 on 2023/02/14.
//

import Foundation


struct MovieVO: Codable {
    
    let resultCount: Int
    let results: [Result]
    
}

struct Result: Codable {
    
    let trackName: String
    let trackViewUrl: String
    let image: String
    let shortDescription: String?
    let longDescription: String?
    let trackPrice: Double
    let currency: String
    let releaseDate: String
    let previewUrl: String
    
    enum CodingKeys: String, CodingKey{
        case image = "artworkUrl100"
        case trackName
        case trackViewUrl
        case shortDescription
        case longDescription
        case trackPrice
        case currency
        case releaseDate
        case previewUrl
    }
    
}
