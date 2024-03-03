//
//  DetailViewTests.swift
//  MarvelTests
//
//  Created by Sergio Amo on 3/3/24.
//

import XCTest
import ViewInspector
@testable import Marvel

final class DetailViewTests: XCTestCase {
    func testDetailView() throws {
        let sut = DetailView(
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
        let exp = sut.inspection.inspect(after: 1) { view in // Get actual view
            let vStackSeries = try view.actualView().inspect().find(viewWithId: "seriesStack")
            XCTAssertNotNil(vStackSeries)
            
            XCTAssertNotNil(view)
            
            let series = try view.actualView().viewModel.marvelItems
            XCTAssertTrue(series?.count ?? 0 > 0, "No series loaded, increasing the delay before inspection might resolve the issue")
            
            let itemCount = try view.actualView().inspect().count
            XCTAssertEqual(itemCount, 1)
            
            // Character Zstack
            let zstack = try view.actualView().inspect().find(viewWithId: 0)
            XCTAssertNotNil(zstack)
            
            // Text charName
            let characterName =  try view.actualView().inspect().find(viewWithId: 1)
            XCTAssertNotNil(characterName)
            
            // ScrollView
            let scrollView = try view.actualView().inspect().find(viewWithId: 2)
            XCTAssertNotNil(scrollView)
            
        }
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 5)
        
    }
}
