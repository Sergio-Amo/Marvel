//
//  ListViewTests.swift
//  MarvelTests
//
//  Created by Sergio Amo on 3/3/24.
//

import XCTest
import ViewInspector
@testable import Marvel

final class ListViewTests: XCTestCase {
    func testListView() throws {
        // Environment will be inserted at ViewHosting.host at the end of this function
        let sut = ListView()
        
        let exp = sut.inspection.inspect(after: 1) { view in // Get actual view
            XCTAssertNotNil(view)
            
            // Test that mocked characters are present
            let characters = try view.actualView().rootViewModel.marvelItems
            XCTAssertTrue(
                characters?.count ?? 0 > 0,
                "No characters loaded, increasing the delay before inspection might resolve the issue"
            )
            
            let list = try view
                .actualView()
                .inspect()
                .find(viewWithId: "characters")
            // Check that there's actual items in the list
            let listItem = try list.find(CharacterCellView.self)
            XCTAssertNotNil(listItem)
        }
        
        ViewHosting.host(view: sut.environmentObject(CharactersViewModel(debug: true)))
        wait(for: [exp], timeout: 5)
        
    }
}
