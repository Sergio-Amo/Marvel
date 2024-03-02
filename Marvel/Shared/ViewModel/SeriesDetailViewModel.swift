//
//  DetailViewModel.swift
//  Marvel
//
//  Created by Sergio Amo on 24/2/24.
//

import Foundation
import Combine

final class SeriesDetailViewModel : ObservableObject {
    @Published var status = Status.none
    @Published var marvelItems: [MarvelItem]? = []
    @Published var itemLimitReached = false
    
    let interactor: MarvelInteractorProtocol
    
    var offset = 0
    var suscriptors = Set<AnyCancellable>()
    
    init(debug: Bool = false) {
        if debug {
            self.interactor = FakeMarvelInteractor()
        } else {
            self.interactor = MarvelInteractor()
        }
    }
    
    func getSeries(id: Int) {
        // This is to be extra careful but shouldn't be needed as the item that
        // triggers the loading shouldn't be appearing if the limit has been reached
        if self.itemLimitReached == true { return }
        if offset == 0 {
            status = .loading
        }
        
        interactor.getSeries(id: id, offset: offset)
            .sink { completion in
                switch completion {
                    case .failure:
                        self.status = .error(error: "Failed to load series")
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
