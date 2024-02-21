//
//  Authentication.swift
//  Marvel
//
//  Created by Sergio Amo on 21/2/24.
//

import Foundation
import CryptoKit

struct Authentication {
    private let publicKey = "INSERT_YOUR_PUBLIC_KEY_HERE"
    private let privateKey = "INSERT_YOUR_PRIVATEKEY_KEY_HERE"
    
    var authParams: String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = string2Md5(string: "\(ts)\(privateKey)\(publicKey)")
        return "apikey=\(publicKey)&ts=\(ts)&hash=\(hash)"
    }
    
    private func string2Md5 (string: String) -> String {
        let digest = Insecure.MD5.hash(data: Data(string.utf8))
        
        return digest.map {
            // 02 : String width = 2 add 0 at the front if width is less than 2
            // hhx: x for hex, hh as lenght modifier specifying that the hex conversion applies to a char
            String(format: "%02hhx", $0)
        }.joined()
    }
}
