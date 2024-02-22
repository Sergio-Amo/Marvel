//
//  RootView.swift
//  Marvel
//
//  Created by Sergio Amo on 21/2/24.
//

import SwiftUI

struct RootView: View {
    // Load the viewModel
    @EnvironmentObject var viewModel: RootViewModel
    
    var body: some View {
        switch viewModel.status {
            case .none:
                withAnimation {
                    Text("None!")
                    // Not sure if i'll use this state
                }
            case .loading:
                withAnimation {
                    Text("Loading!")
                    //LoaderView()
                }
            case .loaded:
                withAnimation {
                    Text("Characters!")
                    //ListView()
                }
            case .error(error: let error):
                withAnimation {
                    Text("Error: \(error)")
                    // ErrorView(error: error)
                }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(RootViewModel(debug: true))
}
