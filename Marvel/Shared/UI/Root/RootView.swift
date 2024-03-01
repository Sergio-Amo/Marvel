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
                    ListView()
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
