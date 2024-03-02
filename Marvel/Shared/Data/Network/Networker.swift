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

final class Networker: NetworkerProtocol {
    // No need for generics as all calls are decoded to the same type
    func callServer(request: URLRequest) -> AnyPublisher<MarvelResponse, Error> {
        URLSession.shared
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
