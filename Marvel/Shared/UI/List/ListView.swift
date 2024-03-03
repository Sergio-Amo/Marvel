//
//  ListView.swift
//  Marvel
//
//  Created by Sergio Amo on 22/2/24.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var rootViewModel: CharactersViewModel
    //Color scheme (Dark/light mode)
    @Environment(\.colorScheme) var colorScheme
    // For ViewInspector
    internal let inspection = Inspection<Self>()
    
    var body: some View {
        NavigationStack {
            List {
                if let characters = rootViewModel.marvelItems {
                    ForEach(characters) { character in
                        CharacterCellView(character: character)
                            .background(
                                NavigationLink(destination: DetailView(
                                    character: character,
                                    interactor: rootViewModel.interactor
                                )) {
                                    EmptyView()
                                }
                            )
                            .listRowSeparator(.hidden)
                            .listRowBackground(colorScheme == .dark ? Color.black : Color.clear)
                    }
                    .id("characters")
                }
                if !rootViewModel.itemLimitReached {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .listRowSeparator(.hidden)
                        .listRowBackground(colorScheme == .dark ? Color.black : Color.clear)
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(2)
                        .padding()
                        .onAppear {
                            rootViewModel.getCharacters()
                        }
                }
            }
            .frame( maxWidth: .infinity)
            .listStyle(GroupedListStyle())
            .navigationTitle("Characters")
        }
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

#Preview {
    ListView()
        .environmentObject(CharactersViewModel(debug: true))
}
