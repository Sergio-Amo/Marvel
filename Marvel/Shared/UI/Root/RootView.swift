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
                    // TODO: Not sure if i'll use this state..
                    // (maybe changhe it to reset and use it to reset the app from the errorView)
                }
            case .loading:
                withAnimation {
                    LoadingView()
                }
            case .loaded:
                withAnimation {
                    ListView()
                }
            case .error(error: let error):
                withAnimation {
                    ErrorView(error: error)
                }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(RootViewModel(debug: true))
}
