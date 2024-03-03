//
//  ErrorViewTests.swift
//  MarvelTests
//
//  Created by Sergio Amo on 3/3/24.
//

import XCTest
import ViewInspector
@testable import Marvel

final class ErrorViewTests: XCTestCase {
    func testErrorView() throws {
        let error = "409"
        let vm = CharactersViewModel()
        
        let view = ErrorView(error: error)
            .environmentObject(vm)

        XCTAssertNotNil(view)
        
        let itemCount = try view.inspect().count
        XCTAssertEqual(itemCount, 1)
        
        //warningStack
        let warningStack = try view.inspect().find(viewWithId: 0)
        XCTAssertNotNil(warningStack)
        
        //buttonStack
        let buttonStack = try view.inspect().find(viewWithId: 1)
        XCTAssertNotNil(buttonStack)
        
        //errorText
        let errorText = try view.inspect().find(viewWithId: 2)
        XCTAssertNotNil(errorText)
        XCTAssertEqual(try errorText.text().string(), error)
        
        //Check that the button exists and triggers vm.status= .none on tap
        let button = try view.inspect().find(button: "Reload App")
        XCTAssertNotNil(button)
        try button.tap()
        XCTAssertEqual(vm.status, .none)
    }
}
