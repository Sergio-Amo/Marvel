//
//  DetailView.swift
//  Marvel
//
//  Created by Sergio Amo on 24/2/24.
//

import SwiftUI

struct DetailView: View {
    var character: MarvelItem
    @StateObject private var viewModel: SeriesDetailViewModel
    
    init(character: MarvelItem, debug: Bool = false) {
        self.character = character
        if (debug) {
           _viewModel = StateObject(wrappedValue: SeriesDetailViewModel(debug: true))
        } else {
           _viewModel = StateObject(wrappedValue: SeriesDetailViewModel())
        }
    }
    var body: some View {
        ScrollView {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom), content: {
                // Image
                if let image = character.thumbnail?.fullPath {
                    AsyncImage(url: image) {
                        $0
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .scaleEffect(4)
                    }
                } else {
                    Image(.imageNotAvailable)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                // Text
                Text(character.name ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                    .padding(.top, 30)
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                    )
                    .id(1)
            })
            .id(0)

            if let series = viewModel.marvelItems,
               viewModel.status != .loaded || !series.isEmpty  {
                HStack {
                    Text("Series")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding([.horizontal, .top], 16)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack{
                        ForEach(series) { serie in
                            VStack{
                                // Image
                                if let image = serie.thumbnail?.fullPathPortrait {
                                    AsyncImage(url: image) {
                                        $0
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                            .scaleEffect(4)
                                    }
                                    .frame(width: 216, height: 324)
                                    .padding([.horizontal, .bottom])
                                    .padding(.top, 8)
                                } else {
                                    Image(.imageNotAvailable)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                                
                                Text(serie.title ?? "No title")
                                    .lineLimit(2)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .truncationMode(.tail)
                                    .frame(height: 8)
                            }
                            .frame(width: 216)
                            .padding(.horizontal, 12)
                            .padding(.bottom, 36)
                            .padding(.top, 0)
                        }
                        // Last item ProgressView that triggers getSeries onAppear
                        if !viewModel.itemLimitReached {
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                .scaleEffect(2)
                                .padding(32)
                                .onAppear {
                                    if let id = character.id {
                                        viewModel.getSeries(id: id)
                                    }
                                }
                        }
                    }
                }
                .id(2)
            }
            
            HStack {
                Text("Description:")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                Spacer()
            }
            .padding([.horizontal, .top], 16)
            
            Text(character.description ?? "No descripion available")
                .padding(12)
                .font(.title3)
            
            Spacer()
        }.onAppear {
            if let id = character.id {
                viewModel.getSeries(id: id)
            }
        }
    }
}

#Preview {
    DetailView(
        character: MarvelItem(
            id: 1,
            name: "Foo Bar Baz",
            description: """
           Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vulputate mi sit amet mauris. Porttitor rhoncus dolor purus non enim. Metus aliquam eleifend mi in nulla posuere sollicitudin. Donec et odio pellentesque diam volutpat commodo sed. At consectetur lorem donec massa sapien faucibus. Ultrices gravida dictum fusce ut placerat orci. Sit amet mauris commodo quis imperdiet massa tincidunt nunc. Velit scelerisque in dictum non consectetur a erat nam at. Semper risus in hendrerit gravida rutrum quisque non tellus orci. At risus viverra adipiscing at in tellus. Quisque sagittis purus sit amet. Lacus vel facilisis volutpat est velit egestas.
           
           Nunc pulvinar sapien et ligula. Senectus et netus et malesuada fames ac turpis. Et egestas quis ipsum suspendisse ultrices gravida. Eget nunc scelerisque viverra mauris. Augue lacus viverra vitae congue eu consequat ac felis. Augue neque gravida in fermentum et sollicitudin ac orci. Dignissim convallis aenean et tortor at. Aenean et tortor at risus viverra adipiscing at in. Egestas diam in arcu cursus euismod. Ac auctor augue mauris augue neque gravida. Aenean et tortor at risus viverra. Sem integer vitae justo eget. Venenatis a condimentum vitae sapien pellentesque. Suspendisse potenti nullam ac tortor. Iaculis urna id volutpat lacus laoreet non. Eros in cursus turpis massa tincidunt dui ut.
           """,
            thumbnail: Thumbnail(
                path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                thumbnailExtension: "jpg")
        ),
        debug: true
    )
}
