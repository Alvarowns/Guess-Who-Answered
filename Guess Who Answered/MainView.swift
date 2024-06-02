//
//  MainView.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 14/5/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var viewModel: MainViewVM
    var body: some View {
        Group {
            switch viewModel.appState {
            case .splash:
                SplashView()
            case .startingView:
                StartingView()
            case .setPlayers:
                SetPlayersView()
            case .addQuestions:
                AddQuestionsView()
            case .setAnswers:
                SetAnswersView()
            case .inGame:
                InGameView()
            case .scores:
                ScoresView()
            }
        }
        .animation(.easeIn, value: viewModel.appState)
    }
}

#Preview {
    MainView()
        .environmentObject(MainViewVM())
}
