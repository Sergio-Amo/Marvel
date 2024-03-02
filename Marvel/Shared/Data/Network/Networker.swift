//
//  Networker.swift
//  Marvel
//
//  Created by Sergio Amo on 2/3/24.
//

import Foundation
import Combine

protocol NetworkerProtocol {
    func callServer(req: URLRequest) -> AnyPublisher<MarvelResponse, Error>
}

final class Networker: NetworkerProtocol {
    // No need for generics as all calls are decoded to the same type
    func callServer(req: URLRequest) -> AnyPublisher<MarvelResponse, Error> {
        URLSession.shared
            .dataTaskPublisher(for: req)
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

final class FakeNetworker: NetworkerProtocol {
    func callServer(req: URLRequest) -> AnyPublisher<MarvelResponse, Error> {
        let items = [
            MarvelItem(id: 1, name: "Foo", description: "Lorem Ipsum 1",
                       thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: "jpg")),
            MarvelItem(id: 2, name: "Bar", description: "Lorem Ipsum 2",
                       thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg")),
            MarvelItem(id: 3, name: "Baz", description: "Lorem Ipsum 3",
                       thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", thumbnailExtension: "jpg")),
            MarvelItem(id: 4, name: "FooBar", description:
                """
                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vulputate mi sit amet mauris. Porttitor rhoncus dolor purus non enim. Metus aliquam eleifend mi in nulla posuere sollicitudin. Donec et odio pellentesque diam volutpat commodo sed. At consectetur lorem donec massa sapien faucibus. Ultrices gravida dictum fusce ut placerat orci. Sit amet mauris commodo quis imperdiet massa tincidunt nunc. Velit scelerisque in dictum non consectetur a erat nam at. Semper risus in hendrerit gravida rutrum quisque non tellus orci. At risus viverra adipiscing at in tellus. Quisque sagittis purus sit amet. Lacus vel facilisis volutpat est velit egestas.

                Nunc pulvinar sapien et ligula. Senectus et netus et malesuada fames ac turpis. Et egestas quis ipsum suspendisse ultrices gravida. Eget nunc scelerisque viverra mauris. Augue lacus viverra vitae congue eu consequat ac felis. Augue neque gravida in fermentum et sollicitudin ac orci. Dignissim convallis aenean et tortor at. Aenean et tortor at risus viverra adipiscing at in. Egestas diam in arcu cursus euismod. Ac auctor augue mauris augue neque gravida. Aenean et tortor at risus viverra. Sem integer vitae justo eget. Venenatis a condimentum vitae sapien pellentesque. Suspendisse potenti nullam ac tortor. Iaculis urna id volutpat lacus laoreet non. Eros in cursus turpis massa tincidunt dui ut.
                """,thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", thumbnailExtension: "jpg")),
            MarvelItem(id: 5, name: "Marvel 5", description: "Lorem Ipsum 5",
                       thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", thumbnailExtension: "jpg")),
            MarvelItem(id: 6, name: "Marvel 6", description: "Lorem Ipsum 6",
                       thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", thumbnailExtension: "jpg")),
            MarvelItem(id: 7, name: "Marvel 7", description: "Lorem Ipsum 7",
                       thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", thumbnailExtension: "jpg")),
        ]
        let data = DataClass(offset: 0, total: 7, count: 7, results: items)
        let response = MarvelResponse(code: 200, data: data)
        let publisher = CurrentValueSubject<MarvelResponse, Error>(response)
        
        return publisher.eraseToAnyPublisher()
    }
}
