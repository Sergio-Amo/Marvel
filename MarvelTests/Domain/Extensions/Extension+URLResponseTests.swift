//
//  Extension+URLResponseTests.swift
//  MarvelTests
//
//  Created by Sergio Amo on 1/3/24.
//

import XCTest
@testable import Marvel

final class computedStatusCodeTests: XCTestCase {

    // SUT
    // URL extension computedStatusCode
    
    let response = HTTPURLResponse(
        url: URL(string: "https://foo.es")!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
    )
    
    // This method will test the computedStatusCode taht extends URLResponse
    func testcomputedStatusCodeTests() throws {
        XCTAssertEqual(response?.computedStatusCode, 200)
    }
}
