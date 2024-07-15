//
//  SplashView.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 24/5/24.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject private var viewModel: MainViewVM
    
    @State private var size: Double = 0.8
    @State private var opacity: Double = 0.5
    
    var body: some View {
        ZStack {
            BackgroundFinalView()
            
                Image(.quizGameLogoNoBackground)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300)
                    .shadow(radius: 3, y: 5)
                    .shadowPop()
                    .titleStyle()
                    .scaleEffect(size)
                    .opacity(opacity)
        }
        .onAppear {
            Task {
                try await Task.sleep(nanoseconds: 2_000_000_000)
                withAnimation(.easeIn(duration: 1.5)) {
                    self.size = 1.0
                    self.opacity = 1.0
                }
                try await Task.sleep(nanoseconds: 5_000_000_000)
                viewModel.appState = .startingView
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(MainViewVM())
}
