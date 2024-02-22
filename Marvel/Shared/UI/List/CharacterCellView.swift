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
        ZStack {
            // Image
            if let image = character.thumbnail?.fullPath {
                AsyncImage(url: image) {
                    $0
                        .resizable()
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(4)
                }
            } else {
                Image(.imageNotAvailable)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            // Text
            VStack{
                Spacer()
                Text(character.name ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                //.frame(minWidth: 0, maxWidth: .infinity)
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color(.white))
                    .padding()
                    .padding(.top, 30)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                    )
                    .id(1)
            }
        }
        .cornerRadius(15)
        .frame(maxHeight: 400)
        .id(0)
    }
}

#Preview {
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
