//
//  RootViewModel.swift
//  Marvel
//
//  Created by Sergio Amo on 22/2/24.
//

import Combine
import Foundation

final class RootViewModel: ObservableObject {
    @Published var status = Status.none
    @Published var marvelItems: [MarvelItem]? = []
    @Published var itemLimitReached = false
    var offset = 0
    
    var suscriptors = Set<AnyCancellable>()
    
    init(debug: Bool = false) {
        if debug {
            getCharactersTesting()
        } else {
            getCharacters()
        }
    }
    
    func getCharacters() {
        // This is to be extra careful but shouldn't be needed as the item that
        // triggers the loading shouldn't be appearing if the limit has been reached
        if self.itemLimitReached == true { return }
        if offset == 0 { // Only trigger the loading view the first time
            status = .loading
        }
        URLSession.shared
            .dataTaskPublisher(for: Network().getCharactersRequest(offset: offset))
            .tryMap {
                guard $0.response.computedStatusCode == 200 else {
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
                if let items = data.data?.results {
                    self.marvelItems? += items
                }
                self.offset += NetworkConstants.itemLimit
                // set itemLimitReached when there's no more items to load
                if let offset = data.data?.offset, let count = data.data?.count, let total = data.data?.total,
                   offset + count == total {
                    self.itemLimitReached = true
                }
            }
            .store(in: &suscriptors)
    }
    
    func getCharactersTesting(){
        self.status = .loading
        self.marvelItems =  getCharactersDesign()
        self.status = .loaded
    }
    
    func getCharactersDesign() -> [MarvelItem] {
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
        return characters
    }
}

