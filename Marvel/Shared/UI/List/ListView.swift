//
//  ListView.swift
//  Marvel
//
//  Created by Sergio Amo on 22/2/24.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        NavigationStack {
            List {
                if let marvel = rootViewModel.marvel,
                   let characters = marvel.data?.results {
                    ForEach(characters) { character in
                        CharacterCellView(character: character)
                            .frame(height: 222)
                            .background(
                                NavigationLink(destination: LoadingView()) { // TODO: Call to detailView with the hero
                                    EmptyView()
                                }
                            )
                    }
                }
            }
            .id(0)
            .frame( maxWidth: .infinity)
            .listStyle(GroupedListStyle())
            .navigationTitle("Characters")
            // TODO: Pagination or Infinite scroll
            /*.toolbar {
                if let marvel = rootViewModel.marvel,
                   let total = marvel.data?.total,
                   let offset = marvel.data?.offset,
                   let count = marvel.data?.count {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if offset >= 100 {
                            Button(action: {
                                rootViewModel.getCharacters(offset: offset - 20)
                            }, label: {
                                Text("< Prev page")
                                    .font(.title3)
                                    .padding(8)
                            })
                        }
                    }
                    ToolbarItem{
                        if total > offset + count {
                            Button(action: {
                                rootViewModel.getCharacters(offset: offset + 20)
                            }, label: {
                                Text("Next page >")
                                    .font(.title3)
                                    .padding(8)
                            })
                        }
                    }
                }
            }*/
        }
    }
}

#Preview {
    ListView()
        .environmentObject(RootViewModel(debug: true))
}
