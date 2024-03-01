//
//  Extension+URLTests.swift
//  MarvelTests
//
//  Created by Sergio Amo on 1/3/24.
//

import XCTest
@testable import Marvel

final class UpgradeUrlSchemeTests: XCTestCase {

    // SUT
    // URL extension upgradeUrlScheme
    let httpUrls = [
        URL(string: "http://foo.bar"),
        URL(string: "http://bar.baz"),
        URL(string: "http://biz.com"),
        URL(string: "http://foo.bar.net"),
        URL(string: "http://test.kc.es")
    ]
    let expectedUrls = [
        URL(string: "https://foo.bar"),
        URL(string: "https://bar.baz"),
        URL(string: "https://biz.com"),
        URL(string: "https://foo.bar.net"),
        URL(string: "https://test.kc.es")
    ]
    
    // This method will test the upgradeUrlScheme url extension
    func testUpgradeUrlScheme() throws {
        let httpsUrls = httpUrls.map{
            $0?.upgradeUrlScheme
        }
        // Test if upgraded urls has expected values
        XCTAssertEqual(httpsUrls, expectedUrls)
        // Check that all urls conform to https scheme
        expectedUrls.forEach {
            XCTAssertTrue($0?.scheme == "https")
        }
    }
}
