//
//  NetworkerTests.swift
//  MarvelTests
//
//  Created by Sergio Amo on 2/3/24.
//

import XCTest
import Combine
@testable import Marvel


/*
 *      TODO: Finsih this test
 *           ¯\_(ツ)_/¯
 */


/*class NetworkerTests: XCTestCase {
    var suscriptors = Set<AnyCancellable>()
    
    func testCallServer() {
        let publisher: AnyPublisher<MarvelResponse, Error> = FakeMarvelInteractor().getSeries(id: 1, offset: 0)
        // Create a mock URLSession
        let mockSession: URLSession = MockURLSession(publisher: publisher)
        
        // Create the Networker instance with the mock URLSession
        let networker = Networker(session: mockSession)
        
        // Create a URLRequest
        let request = URLRequest(url: URL(string: "https://www.example.com")!)
        
        // Call networker
        networker.callServer(request: request)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(let error):
                        XCTFail("\(error)")
                    case .finished:
                        break
                }
            }, receiveValue: { value in
               // TODO: Do some asserts to test everything is ok
            })
            .store(in: &suscriptors)
    }
}

final class MockURLSession: URLSessionProtocol {
    var publisher: AnyPublisher<MarvelResponse, any Error>
    
    init(publisher: AnyPublisher<MarvelResponse, any Error>) {
        self.publisher = publisher
    }
    
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher {
        // I don't know how to return my publisher as URLSession.DataTaskPublisher
    }
}
*/
