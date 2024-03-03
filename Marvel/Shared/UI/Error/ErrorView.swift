//
//  ErrorView.swift
//  Marvel
//
//  Created by Sergio Amo on 22/2/24.
//

import SwiftUI

struct ErrorView: View {
    @EnvironmentObject var rootViewModel: CharactersViewModel
    
    private var error: String
    
    init(error: String) {
        self.error = error
    }
    
    var body: some View {
        Spacer()
        VStack(spacing: 32) {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .frame(width: 212, height: 212)
                .foregroundStyle(.red)
            
            Text(error)
                .font(.title2)
                .bold()
                .id(2)
            
            // This kind of message is not intended for users,
            // but being an example app will be useful for people trying to test it
            Text("Please verify you had added your api keys inside the Authentication file")
                .multilineTextAlignment(.center)
                .bold()
                .font(.subheadline)
                .padding()
        }
        .id(0)
        Spacer()
        VStack {
            Button(action: {
                rootViewModel.status = .none
            }, label: {
                Text("Reload App")
                    .font(.title2)
                    .padding()
                    .frame(width: 300, height: 50)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .cornerRadius(15)
                    .shadow(radius: 10, x: 12, y: 10)
                
            })
            .id(3)
        }
        .id(1)
        .padding()
    }
}

#Preview {
    ErrorView(error: "Error 409: Bad api request!")
        .environmentObject(CharactersViewModel(debug: true))
}
