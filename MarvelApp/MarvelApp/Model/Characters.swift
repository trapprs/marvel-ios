//
//  Characters.swift
//  MarvelApp
//
//  Created by Renan Trapp on 08/01/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import Foundation

struct Characters: Decodable {
    let id: Int?
    let name: String
    let description: String?
    let resourceURI: String?
    let thumbnail: [String: String]?
}

enum Keys: String, CodingKey {
    case id
    case name
    case description
    case resourceURI
    case thumbnail
}

extension Characters {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.resourceURI = try container.decodeIfPresent(String.self, forKey: .resourceURI)
        self.thumbnail = try container.decodeIfPresent([String: String].self, forKey: .thumbnail)
    }
}
