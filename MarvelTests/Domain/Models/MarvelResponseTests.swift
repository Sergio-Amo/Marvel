//
//  MarvelResponseTests.swift
//  MarvelTests
//
//  Created by Sergio Amo on 1/3/24.
//

import XCTest
@testable import Marvel

final class MarvelResponseTests: XCTestCase {
    
    // SUT
    // MarvelResponse model
    var marvel: MarvelResponse?
    
    override func setUp() {
        let items = [
            MarvelItem(
                id: 1,
                name: "name",
                title: "title",
                description: "description",
                thumbnail: Thumbnail(path: "http://test.es/img", thumbnailExtension: "jpg")
            ),
            MarvelItem(
                id: 2,
                name: "name2",
                title: nil,
                description: "description2",
                thumbnail: Thumbnail(path: nil, thumbnailExtension: nil)
            ),
        ]
        let data = DataClass(offset: 1, total: 1, count: 1, results: items)
        marvel = MarvelResponse(code: 200, data: data)
    }
    
    // This method will test the computedStatusCode taht extends URLResponse
    func testMarvelResponse() throws {
        XCTAssertEqual(marvel?.code, 200)
        
        let data = marvel?.data
        XCTAssertEqual(data?.offset, 1)
        XCTAssertEqual(data?.total, 1)
        XCTAssertEqual(data?.count, 1)
        
        let items = data?.results
        XCTAssertEqual(items?.count, 2)
        let item = items?.first
        XCTAssertEqual(item?.id, 1)
        XCTAssertEqual(item?.name, "name")
        XCTAssertEqual(item?.title, "title")
        XCTAssertEqual(item?.description, "description")
        
        let thumbnail = item?.thumbnail
        XCTAssertEqual(thumbnail?.path, "http://test.es/img")
        XCTAssertEqual(thumbnail?.thumbnailExtension, "jpg")
        
        let expectedFullPath = URL(string: "https://test.es/img.jpg")
        XCTAssertEqual(thumbnail?.fullPath, expectedFullPath)
        
        let expectedFullPathLandScape = URL(string: "https://test.es/img/landscape_incredible.jpg")
        XCTAssertEqual(thumbnail?.fullPathLandscape, expectedFullPathLandScape)
        
        let expectedFullPathPortrait = URL(string: "https://test.es/img/portrait_incredible.jpg")
        XCTAssertEqual(thumbnail?.fullPathPortrait, expectedFullPathPortrait)
        
        let nilThumbnail = items?.last?.thumbnail
        XCTAssertEqual(nilThumbnail?.fullPath, nil)
        XCTAssertEqual(nilThumbnail?.fullPathLandscape, nil)
        XCTAssertEqual(nilThumbnail?.fullPathPortrait, nil)
    }
}
