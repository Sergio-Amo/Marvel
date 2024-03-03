//
//  DetailViewTests.swift
//  MarvelTests
//
//  Created by Sergio Amo on 3/3/24.
//

import XCTest
import SwiftUI
import Combine
import ViewInspector
@testable import Marvel

final class DetailViewTests: XCTestCase {
    func testDetailView() throws {
        // This will trigger the error mentioned here:
        // https://github.com/nalexn/ViewInspector/discussions/152
        // Accessing StateObject's object without being installed on a View.
        // This will create a new instance each time.
        // Should only affect tests and not the app itself as this test file is not a view
        let view = DetailView(
            character: MarvelItem(
                id: 1,
                name: "Test Character",
                description: "Lorem ipsum",
                thumbnail: Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                    thumbnailExtension: "jpg")
            ),
            debug: true
        )
        
        XCTAssertNotNil(view)
        
        let itemCount = try view.inspect().count
        XCTAssertEqual(itemCount, 1)
        
        // Character Zstack
        let zstack = try view.inspect().find(viewWithId: 0)
        XCTAssertNotNil(zstack)
        
        // Text charName
        let characterName =  try view.inspect().find(viewWithId: 1)
        XCTAssertNotNil(characterName)
        
        // ScrollView
        let scrollView = try view.inspect().find(viewWithId: 2)
        XCTAssertNotNil(scrollView)
        
        // Series vStack
/*        let vStackSeries = try view.inspect().find(viewWithId: 3)
        XCTAssertNotNil(vStackSeries)
 */
    }
}
