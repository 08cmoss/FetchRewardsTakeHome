//
//  RecipeDTO.swift
//  FetchTakeHome
//
//  Created by Cameron Moss on 2/3/25.
//

import Foundation

struct RecipeDTO: Decodable {
    var recipes: [Recipe]
}

struct Recipe: Decodable, Hashable {
    var uuid: UUID
    var cuisine: String
    var name: String
    var photoURLLarge: String?
    var photoURLSmall: String?
    var sourceURL: String?
    var youtubeURL: String?
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case cuisine
        case name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
    
}

/*
 {
     "recipes": [
         {
             "cuisine": "British",
             "name": "Bakewell Tart",
             "photo_url_large": "https://some.url/large.jpg",
             "photo_url_small": "https://some.url/small.jpg",
             "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
             "source_url": "https://some.url/index.html",
             "youtube_url": "https://www.youtube.com/watch?v=some.id"
         },
         ...
     ]
 }
 */
