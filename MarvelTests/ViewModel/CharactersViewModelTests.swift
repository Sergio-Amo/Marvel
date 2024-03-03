//
//  CharactersViewModelTests.swift
//  MarvelTests
//
//  Created by Sergio Amo on 1/3/24.
//

import XCTest
import Combine
@testable import Marvel

final class CharactersViewModelTests: XCTestCase {
    
    // SUT
    var sut: CharactersViewModel!
    
    override func tearDown() {
        sut = nil
    }
    
    func testgetCharactersTesting() {
        var suscriptors = Set<AnyCancellable>()
        
        let expectationLoading = self.expectation(description: "status.loading")
        let expectationLoaded = self.expectation(description: "status.loaded")
        let expectationCharacters = self.expectation(description: "Characters loaded")
        
        // As get characters runs on init I'll initialize the viewModel here and remove it in teardown
        sut = CharactersViewModel(debug: true)
        
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
                    expectationCharacters.fulfill()
                }
            }.store(in: &suscriptors)
        
        waitForExpectations(timeout: 15)
    }
}
