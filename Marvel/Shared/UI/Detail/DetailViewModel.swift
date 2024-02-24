//
//  DetailViewModel.swift
//  Marvel
//
//  Created by Sergio Amo on 24/2/24.
//

import Foundation
import Combine

final class DetailViewModel : ObservableObject {
    @Published var status = Status.none
    @Published var marvel: [MarvelItem]?
    
    var suscriptors = Set<AnyCancellable>()
    
    func getSeries(id: Int, offset: Int = 0) {
        status = .loading
        
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
                self.marvel = data.data?.results
            }
            .store(in: &suscriptors)
    }
    
    func getSeriesMock() {
        self.status = .loading
        self.marvel =  getSeriesDesign()
        self.status = .loaded
    }
    
    func getSeriesDesign() -> [MarvelItem] {
        let series = [
            MarvelItem(id: 1, title: "Foo", description: nil, thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", thumbnailExtension: "jpg")),
            MarvelItem(id: 2, title: "Bar", description: "foo bar", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/1/00/51644d6b47668", thumbnailExtension: "jpg")),
            MarvelItem(id: 3, title: "Baz", description: nil, thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/d0/51926fde9c18a", thumbnailExtension: "jpg")),
            MarvelItem(id: 4, title: "Biz", description: "lorem ipsum sit amet", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/60/553a60a66f2f6", thumbnailExtension: "jpg")),
            MarvelItem(id: 5, title: "Baz", description: "jhasdjk askdjaskjd auojdhajskd ajodajkg ashashd asdasd.", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/40/553a60e7ab48d", thumbnailExtension: "jpg")),
            MarvelItem(id: 6, title: "FooBar", description: "General Thunderbolt Ross spent years hunting the Hulk, but now he's become one himself! As the rampaging Red Hulk, Ross strives to reconcile the man he used to be with the monster he's becomes, smashing anything that moves along the way!", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/a/d0/4bb4eafadecaf", thumbnailExtension: "jpg"))
            
        ]
        
        return series
    }
    
    
    
}
