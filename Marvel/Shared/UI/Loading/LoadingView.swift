//
//  LoadingView.swift
//  Marvel
//
//  Created by Sergio Amo on 22/2/24.
//

import SwiftUI

struct LoadingView: View {
    @State private var isRotating = 0.0
    
    var animation: Animation {
        Animation.easeOut
    }
    
    var body: some View {
        
        VStack(spacing: 32) {
            Image(systemName: "timelapse")
                .resizable()
                .frame(width: 128, height: 128)
                .symbolEffect(.pulse)
                .rotationEffect(.degrees(isRotating))
                .onAppear {
                    withAnimation(.linear(duration: 12)
                        .repeatForever(autoreverses: false)) {
                            isRotating = 360.0
                        }
                }
                .id(0)
            
            Text("Loading, please wait")
                .font(.title)
                .id(1)
        }
    }
}

#Preview {
    LoadingView()
}
