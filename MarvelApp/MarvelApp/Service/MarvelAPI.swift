//
//  MarvelAPI.swift
//  MarvelApp
//
//  Created by Renan Trapp on 08/01/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import UIKit

struct MarvelAPIAuth {
    static let url: String = "https://gateway.marvel.com:443/v1/public/characters"
    static let publicKey: String = "b6e729e1b383c76a5c57de217a2d671a"
    static let privateKey: String = "6d846433c10c54d50f533cee3025a0382964c129"
}

struct Marvel {
    
    typealias CompletionProposals = (Result<CharacterDataWrapper>) -> Void
    typealias ImageLoad = (Result<UIImageView>) -> Void
    
    mutating func listCharacters(_ offset: Int, completion: @escaping CompletionProposals) {
        let timestamp = Date().ticks
        
        let hash = MD5().getHash(timestamp, MarvelAPIAuth.privateKey, MarvelAPIAuth.publicKey)
        let stringUrl: String = "\(MarvelAPIAuth.url)?limit=20&offset=\(offset)&ts=\(timestamp)&apikey=\(MarvelAPIAuth.publicKey)&hash=\(hash)"

        Service.requestAPI(url: stringUrl, completion: { (result) in
            let newResult = result.flatMap { try JSONDecoder().decode(CharacterDataWrapper.self, from: $0) }
            completion(newResult)
        })
    }
    mutating func searchCharacters(_ offset: Int, _ search: String, completion: @escaping CompletionProposals) {
        let timestamp = Date().ticks
        
        let hash = MD5().getHash(timestamp, MarvelAPIAuth.privateKey, MarvelAPIAuth.publicKey)
        let stringUrl: String = "\(MarvelAPIAuth.url)?nameStartsWith=\(search)&limit=20&offset=\(offset)&ts=\(timestamp)&apikey=\(MarvelAPIAuth.publicKey)&hash=\(hash)"
        
        Service.requestAPI(url: stringUrl, completion: { (result) in
            let newResult = result.flatMap { try JSONDecoder().decode(CharacterDataWrapper.self, from: $0) }
            completion(newResult)
        })
    }
    
    
}
