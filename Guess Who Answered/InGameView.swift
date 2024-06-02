//
//  ContentView.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 13/5/24.
//

import SwiftUI
import ConfettiSwiftUI

struct InGameView: View {
    @EnvironmentObject private var viewModel: MainViewVM
    
    @State private var playerSelected: String = ""
    @State private var currentPlayer: String = ""
    @State private var currentAnswer: String = ""
    @State private var correctAnswerAnimation: Bool = false
    @State private var wrongAnswerAnimation: Bool = false
    @State private var confettiCounter: Int = 0
    @State private var wrongConfettiCounter: Int = 0
    @State private var nextPlayer: Bool = false
    @State private var gameOverView: Bool = false
    @State private var earlyGameOver: Bool = false
    @State private var gameOverAppState: AppState = .scores
    @State private var nextRoundAppState: AppState = .setAnswers
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                HeaderView()
                
                VStack(alignment: .center, spacing: 2) {
                    Text("Le toca jugar a:")
                        .font(.headline)
                    
                    Text(currentPlayer)
                        .animation(.easeIn)
                        .font(.title3)
                }
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding(8)
                .background {
                    Capsule()
                        .foregroundStyle(.white)
                }
                .shadowPop()
                .padding([.top, .horizontal])
                
                Text(viewModel.currentRandomQuestion)
                    .frame(maxWidth: .infinity)
                    .font(.title3)
                    .fontWeight(.heavy)
                    .textInputAutocapitalization(.sentences)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 18)
                            .foregroundStyle(.blue)
                            .opacity(0.5)
                    }
                    .shadowPop()
                    .titleStyle()
                    .padding([.top, .horizontal])
                
                VStack(alignment: .leading, spacing: 5) {
                    VStack(alignment: .leading) {
                        Text("Respuesta: ")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .shadowPop()
                        
                        withAnimation(.easeIn) {
                            Text(currentAnswer)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .textInputAutocapitalization(.sentences)
                                .multilineTextAlignment(.center)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 18)
                                        .foregroundStyle(.blue)
                                        .opacity(0.5)
                                }
                        }
                    }
                    .shadowPop()
                    .titleStyle()
                    
                    VStack {
                        Text("¿De quién es la respuesta?")
                            .font(.headline)
                            .padding(.top, 2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .shadowPop()
                            .shadowPop()
                            .titleStyle()
                        
                        
                        ScrollView(.vertical) {
                            ForEach(viewModel.playersAndAnswers.sorted(by: {$0.key < $1.key}), id: \.key) { name, answer in
                                if name != currentPlayer {
                                    PlayerButton(playerName: name,
                                                 playerSelected: $playerSelected)
                                }
                            }
                        }
                        .scrollIndicators(.never)
                    }
                }
                .padding(.horizontal)
                
                
                Text("CONTINUAR")
                    .primaryButton()
                    .onTapGesture {
                        withAnimation {
                            if playerSelected == viewModel.playersAndAnswers.first(where: {$0.value == currentAnswer})?.key  {
                                viewModel.updatePlayerScore(player: currentPlayer)
                                viewModel.rightAnswers.updateValue(true, forKey: currentAnswer)
                                correctAnswerAnimation.toggle()
                                confettiCounter += 1
                                updateCurrentPlayerAndAnswer()
                                viewModel.ifEveryAnswerIsTrueThenUpdateNumberOfQestionAnswered()
                                playerSelected = ""
                                nextPlayer.toggle()
                            } else {
                                wrongAnswerAnimation.toggle()
                                wrongConfettiCounter += 1
                                updateCurrentPlayerAndAnswer()
                                playerSelected = ""
                                nextPlayer.toggle()
                            }
                        }
                    }
                
                Text("TERMINAR JUEGO")
                    .foregroundStyle(.red)
                    .font(.headline)
                    .shadowPop()
                    .titleStyle()
                    .onTapGesture {
                        earlyGameOver.toggle()
                    }
            }
            .blur(radius: earlyGameOver || gameOverView || nextPlayer ? 2 : 0)
            .disabled(gameOverView || nextPlayer ? true : false)
            
            PopUpChangePlayer(title: "¡HAS ACERTADO! 🥳\n\nLe toca jugar a:", playerName: $currentPlayer, next: $nextPlayer, updateAnswer: $correctAnswerAnimation)
                .opacity(nextPlayer && correctAnswerAnimation ? 1.0 : 0.0)
                .confettiCannon(counter: $confettiCounter, num: 150, confettiSize: 15, radius: 350)
            
            PopUpChangePlayer(title: "NO HAS ACERTADO 👎🏻\n\nLe toca jugar a:", playerName: $currentPlayer, next: $nextPlayer, updateAnswer: $wrongAnswerAnimation)
                .opacity(nextPlayer && wrongAnswerAnimation ? 1.0 : 0.0)
            
            PopUpChangeAppState(title: "¡HAS ACERTADO! 🥳\n\nRONDA TERMINADA", buttonTitle: "SIGUIENTE", appState: $nextRoundAppState)
                .opacity(!gameOverView && correctAnswerAnimation && viewModel.rightAnswers.values.allSatisfy({$0 == true}) ? 1.0 : 0.0)
                .confettiCannon(counter: $confettiCounter, num: 150, confettiSize: 15, radius: 350)
            
            PopUpChangeAppState(title: "NO HAS ACERTADO 👎🏻\n\nRONDA TERMINADA", buttonTitle: "SIGUIENTE", appState: $nextRoundAppState)
                .opacity(!gameOverView && wrongAnswerAnimation && viewModel.rightAnswers.values.allSatisfy({$0 == true}) ? 1.0 : 0.0)
                .confettiCannon(counter: $confettiCounter, num: 150, confettiSize: 15, radius: 350)
            
            PopUpChangeAppState(title: "¡HAS ACERTADO! 🥳\n\nJUEGO TERMINADO", buttonTitle: "RESULTADOS", appState: $gameOverAppState)
                .opacity(gameOverView && correctAnswerAnimation ? 1.0 : 0.0)
                .confettiCannon(counter: $confettiCounter, num: 150, confettiSize: 15, radius: 350)
            
            PopUpChangeAppState(title: "NO HAS ACERTADO 👎🏻\n\nJUEGO TERMINADO", buttonTitle: "RESULTADOS", appState: $gameOverAppState)
                .opacity(gameOverView && wrongAnswerAnimation ? 1.0 : 0.0)
        }
        .background(BackgroundFinalView())
        .onAppear {
            updateCurrentPlayerAndAnswer()
            viewModel.questionsAlreadyAsked(question: viewModel.currentRandomQuestion)
        }
        .onChange(of: viewModel.numberOfQuestionsAnswered) {
            if viewModel.numberOfQuestionsAnswered == viewModel.numberOfPlayers + 1 {
                gameOverView.toggle()
            }
        }
        .alert("¿Estás segur@ de que quieres terminar el juego antes de tiempo?", isPresented: $earlyGameOver) {
            Button("Aceptar") {
                viewModel.appState = .scores
            }
            Button("Cancelar", role: .cancel) {
                earlyGameOver.toggle()
            }
        } message: {
            Text("Irás directamente a la pantalla de RESULTADOS y deberás empezar un juego nuevo")
        }
    }
    
    
    private func updateCurrentPlayerAndAnswer() {
        if let result = viewModel.selectNextPlayerAndRandomAnswer() {
            self.currentPlayer = result.player
            self.currentAnswer = result.answer
        }
    }
}

#Preview {
    InGameView()
        .environmentObject(MainViewVM())
}
