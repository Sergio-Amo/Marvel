//
//  StatusModelTests.swift
//  MarvelTests
//
//  Created by Sergio Amo on 1/3/24.
//

import XCTest
@testable import Marvel

final class StatusModelTests: XCTestCase {
    func testStatusModel() {
        XCTAssertNotNil(Status.none)
        XCTAssertNotNil(Status.loading)
        XCTAssertNotNil(Status.loaded)
        let error1 = Status.error(error: "Error1")
        // Check value of error1
        if case .error(let actual) = error1 {
            XCTAssertEqual(actual, "Error1")
        } else {
            XCTFail("Error getting Status error value")
        }
    }
}
