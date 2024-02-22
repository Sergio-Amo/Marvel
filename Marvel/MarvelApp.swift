//
//  MarvelApp.swift
//  Marvel
//
//  Created by Sergio Amo on 21/2/24.
//

import SwiftUI

@main
struct MarvelApp: App {
    
    @StateObject var rootViewModel = RootViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(rootViewModel)
        }
    }
}
