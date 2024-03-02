//
//  CharactersViewModel.swift
//  Marvel
//
//  Created by Sergio Amo on 22/2/24.
//

import Combine
import Foundation

final class CharactersViewModel: ObservableObject {
    @Published var status = Status.none
    @Published var marvelItems: [MarvelItem]? = []
    @Published var itemLimitReached = false
    var offset = 0
    
    let interactor: MarvelInteractorProtocol
    var suscriptors = Set<AnyCancellable>()
    
    init(debug: Bool = false) {
        if debug {
            self.interactor = FakeMarvelInteractor()
        } else {
            self.interactor = MarvelInteractor()
        }
        getCharacters()
    }
    
    func getCharacters() {
        // This is to be extra careful but shouldn't be needed as the item that
        // triggers the loading shouldn't be appearing if the limit has been reached
        if self.itemLimitReached == true { return }
        if offset == 0 { // Only trigger the loading view the first time
            status = .loading
        }
        interactor.getCharacters(offset: offset)
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
}

