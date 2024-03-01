//
//  AuthenticationTests.swift
//  MarvelTests
//
//  Created by Sergio Amo on 1/3/24.
//

import XCTest
@testable import Marvel

final class AuthenticationTests: XCTestCase {

    // SUT
    let authentication = Authentication()

    // This method will work with the actual keys but also with the placeholders
    // and will not fail in any of its cases as it's checking wether the hash can be created
    // the hash and timestamps changes, the structure is well constructed and the rest stays the
    // same along calls
    func testAuthentication() throws {
        let authParams = authentication.authParams
        let authParams2 = authentication.authParams
        
        let actual1 = authParams.components(separatedBy: CharacterSet(charactersIn: "=&"))
        let actual2 = authParams2.components(separatedBy: CharacterSet(charactersIn: "=&"))
        
        // The string apikey
        XCTAssertEqual(actual1[0], "apikey")
        XCTAssertEqual(actual2[0], "apikey")
        // Api key value
        XCTAssertEqual(actual1[1], actual2[1])
        //The string ts
        XCTAssertEqual(actual1[2], "ts")
        XCTAssertEqual(actual2[2], "ts")
        // Time stamp (should be different)
        XCTAssertNotEqual(actual1[3], actual2[3])
        // The string hash
        XCTAssertEqual(actual1[4], "hash")
        XCTAssertEqual(actual2[4], "hash")
        // hash should be different cause it uses the timestamp as part of it
        // hash = md5(ts+privateKey+publicKey)
        XCTAssertNotEqual(actual1[5], actual2[5])
    }
}
