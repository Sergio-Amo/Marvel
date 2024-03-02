//
//  Networker.swift
//  Marvel
//
//  Created by Sergio Amo on 2/3/24.
//

import Foundation
import Combine

protocol NetworkerProtocol {
    func callServer(request: URLRequest) -> AnyPublisher<MarvelResponse, Error>
}

protocol URLSessionProtocol {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
}
extension URLSession: URLSessionProtocol {
    static var defaultSession: URLSessionProtocol {
        return URLSession(configuration: .default)
    }
}

final class Networker: NetworkerProtocol {
    private let session: URLSessionProtocol
    init(session: URLSessionProtocol = URLSession(configuration: .default)) {
        self.session = session
    }
    // No need for generics as all calls are decoded to the same type
    func callServer(request: URLRequest) -> AnyPublisher<MarvelResponse, Error> {
        session
            .dataTaskPublisher(for: request)
            .tryMap {
                guard $0.response.computedStatusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return $0.data
            }
            .decode(type: MarvelResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
