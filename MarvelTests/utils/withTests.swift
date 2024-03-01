//
//  withTests.swift
//  MarvelTests
//
//  Created by Sergio Amo on 1/3/24.
//

import XCTest
@testable import Marvel

final class WithTests: XCTestCase {

    // SUT
    //global function `with`

    enum Constants {
        static let foo = "hello"
        static let bar = "world"
        static let bang = "!"
    }
    let numArray = [1,2,3,4,5]
    
    // This method will test the kotlin like with function added to the project
    func testAuthentication() throws {
        let helloWorld = with(Constants.self) {
            XCTAssertEqual($0.foo, "hello")
            XCTAssertEqual($0.bar, "world")
            XCTAssertEqual($0.bang, "!")
            return "\($0.foo) \($0.bar)\($0.bang)"
        }
        XCTAssertEqual(helloWorld, "hello world!")
        
        with(numArray) {
            XCTAssertTrue($0.first == 1)
            XCTAssertTrue($0.last == 5)
        }
    }
}
