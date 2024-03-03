//
//  CharacterCellView.swift
//  Marvel
//
//  Created by Sergio Amo on 22/2/24.
//

import SwiftUI

struct CharacterCellView: View {
    
    var character: MarvelItem
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom), content: {
            // Image
            if let image = character.thumbnail?.fullPathLandscape {
                AsyncImage(url: image) {
                    $0
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(4)
                        .frame(width: 400, height: 222)
                        .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            } else {
                Image(.imageNotAvailable)
                    .resizable()
                    .scaledToFit()
            }
            Text(character.name ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .bold()
                .foregroundStyle(Color(.white))
                .padding()
                .padding(.top, 30)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                )
        })
        .cornerRadius(15)
    }
}

#Preview {
    List {
        CharacterCellView(
            character: MarvelItem(
                id: 1,
                name: "A very long name for a marvel character",
                description: "LoremIpsum",
                thumbnail: Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                    thumbnailExtension: "jpg")
            ))
    }
    .frame( maxWidth: .infinity)
    #if os(OSX)
    .listStyle(DefaultListStyle())
    #else
    .listStyle(GroupedListStyle())
    #endif
}
