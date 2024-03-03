//
//  SeriesDetailViewModelTests.swift
//  MarvelTests
//
//  Created by Sergio Amo on 3/3/24.
//

import XCTest
import Combine
@testable import Marvel

final class SeriesDetailViewModelTests: XCTestCase {
    
    // SUT
    var sut: SeriesDetailViewModel!
    
    override func setUp() {
        sut = SeriesDetailViewModel(debug: true, interactor: FakeMarvelInteractor())
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testGetSeries() {
        var suscriptors = Set<AnyCancellable>()
        
        let expectationLoading = self.expectation(description: "status.loading")
        let expectationLoaded = self.expectation(description: "status.loaded")
        let expectationSeries = self.expectation(description: "Series loaded")
        
        // TODO: GET STUFF
        sut.getSeries(id: 1)
        
        // Check if it enters in loading and then loaded
        sut.$status // publisher in @Published is exposed like this
            .sink{ status in
                switch status {
                    case .loading:
                        expectationLoading.fulfill()
                    case .loaded:
                        expectationLoaded.fulfill()
                    case .none:
                        print("sut status initialized to none")
                    default:
                        XCTFail("Wrong status \(status)")
                        
                }
            }.store(in: &suscriptors)
        
        // Check the 4 mock items are received
        sut.$marvelItems
            .sink { item in
                if (item?.count ?? 0 > 0) {
                    expectationSeries.fulfill()
                }
            }.store(in: &suscriptors)
        
        waitForExpectations(timeout: 5)
    }
}
