//
//  MarvelInteractor.swift
//  Marvel
//
//  Created by Sergio Amo on 2/3/24.
//

import Foundation
import Combine

protocol MarvelInteractorProtocol {
    func getCharacters(offset: Int) -> AnyPublisher<MarvelResponse, Error>
    func getSeries(id: Int, offset: Int) -> AnyPublisher<MarvelResponse, Error>
}

final class MarvelInteractor: MarvelInteractorProtocol {
    
    let network: Network
    let networker: NetworkerProtocol
    
    init(network: Network = Network(), networker: NetworkerProtocol = Networker()) {
        self.network = network
        self.networker = networker
    }
    
    func getCharacters(offset: Int) -> AnyPublisher<MarvelResponse, Error> {
        let request = network.getCharactersRequest(offset: offset)
        return networker.callServer(request: request)
    }
    
    func getSeries(id: Int, offset: Int) -> AnyPublisher<MarvelResponse, Error> {
        let request = network.getCharacterSeriesRequest(id: id, offset: offset)
        return networker.callServer(request: request)
    }
}

final class FakeMarvelInteractor: MarvelInteractorProtocol {
    func getCharacters(offset: Int) -> AnyPublisher<MarvelResponse, Error> {
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
        
        //Emit once and finish
        return Just(response)
            .delay(for: .seconds(0.15), scheduler: DispatchQueue.global(qos: .userInitiated))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
    }
    
    func getSeries(id: Int, offset: Int) -> AnyPublisher<MarvelResponse, Error> {
        let items = [
            MarvelItem(id: 1, title: "Foo", description: nil, thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", thumbnailExtension: "jpg")),
            MarvelItem(id: 2, title: "Bar", description: "foo bar", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/1/00/51644d6b47668", thumbnailExtension: "jpg")),
            MarvelItem(id: 3, title: "Very long serie name (123-456)", description: nil, thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/d0/51926fde9c18a", thumbnailExtension: "jpg")),
            MarvelItem(id: 4, title: "Biz", description: "lorem ipsum sit amet", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/60/553a60a66f2f6", thumbnailExtension: "jpg")),
            MarvelItem(id: 5, title: "Baz", description: "jhasdjk askdjaskjd auojdhajskd ajodajkg ashashd asdasd.", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/40/553a60e7ab48d", thumbnailExtension: "jpg")),
            MarvelItem(id: 6, title: "FooBar", description: "General Thunderbolt Ross spent years hunting the Hulk, but now he's become one himself! As the rampaging Red Hulk, Ross strives to reconcile the man he used to be with the monster he's becomes, smashing anything that moves along the way!", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/a/d0/4bb4eafadecaf", thumbnailExtension: "jpg"))
        ]
        let data = DataClass(offset: 0, total: 6, count: 6, results: items)
        let response = MarvelResponse(code: 200, data: data)
        
        //Emit once and finish
        return Just(response)
            .delay(for: .seconds(0.15), scheduler: DispatchQueue.global(qos: .userInitiated))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
