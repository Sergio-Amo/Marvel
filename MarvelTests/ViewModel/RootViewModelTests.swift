//
//  RootViewModelTests.swift
//  MarvelTests
//
//  Created by Sergio Amo on 1/3/24.
//

import XCTest
import Combine
@testable import Marvel

final class RootViewModelTests: XCTestCase {
    
    // SUT
    let sut = RootViewModel()
    
    func testRootViewModel() {
        
    }
    
    func testgetCharactersTesting() {
        var suscriptors = Set<AnyCancellable>()
        
        let expectationLoading = self.expectation(description: "status.loading")
        let expectationLoaded = self.expectation(description: "status.loaded")
        let expectationCharacters = self.expectation(description: "Characters loaded")
        
        var checkOnce = false
        // Check if it enters in loading and then loaded
        let status: () = sut.$status
            .sink{ status in
                switch status {
                    case .loading:
                        if (!checkOnce){
                            checkOnce = true
                            expectationLoading.fulfill()
                        }
                    case .loaded:
                        expectationLoaded.fulfill()
                    default:
                        XCTFail("Wrong status \(status)")
                        
                }
            }.store(in: &suscriptors)
        
        // Check the 4 mock items are received
        let items: () = sut.$marvelItems
            .sink { item in
                if (item?.count == 4) {
                    expectationCharacters.fulfill()
                }
            }.store(in: &suscriptors)
        
        sut.getCharactersTesting()
        
        waitForExpectations(timeout: 5)
    }
    
    func testCharacterTesting() {
        let characters = sut.getCharactersDesign()
        XCTAssertEqual(characters.count, 4)
    }
}
