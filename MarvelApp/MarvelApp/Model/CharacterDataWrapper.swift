//
//  MarvelAPI.swift
//  MarvelApp
//
//  Created by Renan Trapp on 08/01/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//
import Foundation

struct CharacterDataWrapper: Decodable {
    let code: Int?
    let status: String?
    let data: CharacterDataContainer?
}

enum CharacterDataWrapperKeys: String, CodingKey {
    case code
    case status
    case data
}

extension CharacterDataWrapper {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CharacterDataWrapperKeys.self)
        self.code = try container.decodeIfPresent(Int.self, forKey: .code)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.data = try container.decodeIfPresent(CharacterDataContainer.self, forKey: .data)
    }
}


