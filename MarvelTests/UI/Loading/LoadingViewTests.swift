//
//  LoadingViewTests.swift
//  MarvelTests
//
//  Created by Sergio Amo on 3/3/24.
//

import XCTest
import ViewInspector
@testable import Marvel

final class LoadingViewTests: XCTestCase {
    func testLoadingView() throws {
        // Sut
        let view = LoadingView()

        XCTAssertNotNil(view)
        
        XCTAssertNotNil(view.animation)
        
        let itemCount = try view.inspect().count
        XCTAssertEqual(itemCount, 1)
        
        //Image
        let warningStack = try view.inspect().find(viewWithId: 0)
        XCTAssertNotNil(warningStack)
        
        //Text
        let loadingText = try view.inspect().find(viewWithId: 1)
        XCTAssertNotNil(loadingText)
        XCTAssertEqual(try loadingText.text().string(), "Loading, please wait")

    }
}
