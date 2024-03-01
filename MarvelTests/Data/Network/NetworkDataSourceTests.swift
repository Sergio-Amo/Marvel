//
//  NetworkDataSourceTests.swift
//  MarvelTests
//
//  Created by Sergio Amo on 1/3/24.
//

import XCTest
@testable import Marvel


struct AuthenticationMock: AuthenticationProtocol {
    var authParams: String = "apikey=MyApiKey&ts=MyTs&hash=MyHash"
}


final class NetworkDataSourceTests: XCTestCase {
    
    // SUT
    let network = Network(auth: AuthenticationMock())
    
    func testHTTPMethods() {
        XCTAssertEqual(HTTPMethods.get, "GET")
        XCTAssertEqual(HTTPMethods.content, "application/json")
        XCTAssertEqual(HTTPMethods.contentType, "Content-type")
    }
    
    func testNetworkConstants() {
        let limit: Int = NetworkConstants.itemLimit
        XCTAssertGreaterThan(limit, 0)
        XCTAssertEqual(NetworkConstants.limit, "?limit=\(limit)")
        XCTAssertEqual(NetworkConstants.baseUrl, "https://gateway.marvel.com/v1/public")
        XCTAssertEqual(NetworkConstants.charactersUrl, "\(NetworkConstants.baseUrl)/characters")
        XCTAssertEqual(NetworkConstants.seriesUrl, "\(NetworkConstants.baseUrl)/series")
        
        let itemOffset = NetworkConstants.itemOffset(42)
        XCTAssertEqual(itemOffset, "&offset=42")
        let characterID = NetworkConstants.characterID(42)
        XCTAssertEqual(characterID, "&characters=42")
    }
    
    
    func testgetCharactersRequest() {
        let req: URLRequest = network.getCharactersRequest(offset: 42)
        
        // Then
        XCTAssertEqual(req.httpMethod, "GET")
        XCTAssertEqual(req.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        let components = URLComponents(url: req.url!, resolvingAgainstBaseURL: false)?.queryItems
        
        var cases: Set<String> = ["limit", "offset", "apikey", "ts", "hash"]
        components?.forEach{ component in
            switch(component.name) {
                case "limit":
                    XCTAssertEqual(component.value, "\(NetworkConstants.itemLimit)")
                case "offset":
                    XCTAssertEqual(component.value, "42")
                case "apikey":
                    XCTAssertEqual(component.value, "MyApiKey")
                case "ts":
                    XCTAssertEqual(component.value, "MyTs")
                case "hash":
                    XCTAssertEqual(component.value, "MyHash")
                default:
                    XCTFail("Unexpected component \(component.name)")
            }
            cases.remove(component.name)
        }
        XCTAssertTrue(cases.isEmpty, "\(cases) were not checked")
    }
    
    func testgetCharacterSeriesRequest() {
        let req: URLRequest = network.getCharacterSeriesRequest(id: 42, offset: 42)
        
        // Then
        XCTAssertEqual(req.httpMethod, "GET")
        XCTAssertEqual(req.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        let components = URLComponents(url: req.url!, resolvingAgainstBaseURL: false)?.queryItems
        
        var cases: Set<String> = ["limit", "offset", "apikey", "ts", "hash"]
        components?.forEach{ component in
            switch(component.name) {
                case "limit":
                    XCTAssertEqual(component.value, "\(NetworkConstants.itemLimit)")
                case "offset":
                    XCTAssertEqual(component.value, "42")
                case "apikey":
                    XCTAssertEqual(component.value, "MyApiKey")
                case "ts":
                    XCTAssertEqual(component.value, "MyTs")
                case "hash":
                    XCTAssertEqual(component.value, "MyHash")
                case "characters":
                    XCTAssertEqual(component.value, "42")
                default:
                    XCTFail("Unexpected component \(component.name)")
            }
            cases.remove(component.name)
        }
        XCTAssertTrue(cases.isEmpty, "\(cases) were not checked")
    }
}
