//
//  RootViewModel.swift
//  Marvel
//
//  Created by Sergio Amo on 22/2/24.
//

import Combine
import Foundation

enum Status {
    case none, loading, loaded, error(error: String)
}

final class RootViewModel: ObservableObject {
    @Published var status = Status.none
    @Published var marvel: MarvelResponse?
    
    var suscriptors = Set<AnyCancellable>()
    
    init(debug: Bool = false) {
        if debug {
            getCharactersTesting()
        } else {
            getCharacters(offset: 0)
        }
    }
    
    func getCharacters(offset: Int) {
        status = .loading
        
        URLSession.shared
            .dataTaskPublisher(for: Network().getCharactersRequest(offset: offset))
            .tryMap {
                guard $0.response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return $0.data
            }
            .decode(type: MarvelResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .failure:
                        self.status = .error(error: "Failed to load characters")
                    case .finished:
                        self.status = .loaded
                }
            } receiveValue: { data in
                self.marvel = data
            }
            .store(in: &suscriptors)
    }
    
    
    // TODO: move this to network testing
    
    func getCharactersTesting(){
        self.status = .loading
        self.marvel =  getCharactersDesign()
        self.status = .loaded
    }
    
    func getCharactersDesign() -> MarvelResponse {
        let characters = [
            MarvelItem(id: 1, name: "Foo", description: "Lorem Ipsum 1",
                       thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: "jpg")),
            MarvelItem(id: 2, name: "Bar", description: "Lorem Ipsum 2",
                       thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg")),
            MarvelItem(id: 3, name: "Baz", description: "Lorem Ipsum 3",
                       thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", thumbnailExtension: "jpg")),
            MarvelItem(id: 4, name: "FooBar", description: """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vulputate mi sit amet mauris. Porttitor rhoncus dolor purus non enim. Metus aliquam eleifend mi in nulla posuere sollicitudin. Donec et odio pellentesque diam volutpat commodo sed. At consectetur lorem donec massa sapien faucibus. Ultrices gravida dictum fusce ut placerat orci. Sit amet mauris commodo quis imperdiet massa tincidunt nunc. Velit scelerisque in dictum non consectetur a erat nam at. Semper risus in hendrerit gravida rutrum quisque non tellus orci. At risus viverra adipiscing at in tellus. Quisque sagittis purus sit amet. Lacus vel facilisis volutpat est velit egestas.

Nunc pulvinar sapien et ligula. Senectus et netus et malesuada fames ac turpis. Et egestas quis ipsum suspendisse ultrices gravida. Eget nunc scelerisque viverra mauris. Augue lacus viverra vitae congue eu consequat ac felis. Augue neque gravida in fermentum et sollicitudin ac orci. Dignissim convallis aenean et tortor at. Aenean et tortor at risus viverra adipiscing at in. Egestas diam in arcu cursus euismod. Ac auctor augue mauris augue neque gravida. Aenean et tortor at risus viverra. Sem integer vitae justo eget. Venenatis a condimentum vitae sapien pellentesque. Suspendisse potenti nullam ac tortor. Iaculis urna id volutpat lacus laoreet non. Eros in cursus turpis massa tincidunt dui ut.
"""
                       ,
                       thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", thumbnailExtension: "jpg"))
        ]
        return MarvelResponse(code: 200, data: DataClass(offset: 100, total: 1000, count: 4, results: characters))
    }
}

