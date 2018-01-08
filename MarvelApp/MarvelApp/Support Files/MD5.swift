//
//  MD5.swift
//  MarvelApp
//
//  Created by Renan Trapp on 08/01/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//


import Foundation

class MD5 {
    func generateMD5(string: String) -> Data {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData
    }
    
    func getHash(_ time: UInt64, _ privateKey: String, _ publicKey: String) -> String {
        let md5 = self.generateMD5(string: "\(time)\(privateKey)\(publicKey)")
        let hashReturn =  md5.map { String(format: "%02hhx", $0) }.joined()
        
        return hashReturn
    }
}



