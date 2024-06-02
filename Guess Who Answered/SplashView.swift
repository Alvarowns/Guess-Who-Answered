//
//  SplashView.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 24/5/24.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject private var viewModel: MainViewVM
    
    @State private var setUpLogo: Bool = false
    @State private var animationBounce: Bool = false
    
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
                    .opacity(setUpLogo ? 1.0 : 0.0)
                    .scaleEffect(animationBounce ? 1.1 : 0.9)
                    .animation(
                        Animation.bouncy.repeatCount(5), value: animationBounce
                    )
        }
        .onAppear {
            Task {
                try await Task.sleep(nanoseconds: 2_000_000_000)
                setUpLogo.toggle()
                animationBounce.toggle()
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
