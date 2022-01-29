//
//  MovieModel.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

struct MovieBaseModel: Decodable {
    let results: [MovieModel]!
}

struct MovieModel: Decodable {
    let poster_path: String!
    let original_title: String!
    
    enum CodingKeys: String, CodingKey {
        case poster_path = "poster_path"
        case original_title = "original_title"
    }
}
