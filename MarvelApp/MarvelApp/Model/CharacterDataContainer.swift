//
//  CharacterDataContainer.swift
//  MarvelApp
//
//  Created by Renan Trapp on 08/01/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import Foundation

struct CharacterDataContainer: Decodable {
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Characters]?
}

enum CharacterDataContainerKeys: String, CodingKey {
    case limit
    case total
    case count
    case results
}

extension CharacterDataContainer {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CharacterDataContainerKeys.self)
        self.limit = try container.decodeIfPresent(Int.self, forKey: .limit)
        self.total = try container.decodeIfPresent(Int.self, forKey: .total)
        self.count = try container.decodeIfPresent(Int.self, forKey: .count)
        self.results = try container.decodeIfPresent([Characters].self, forKey: .results)
    }
}

