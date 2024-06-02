//
//  SetAnswersView.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 14/5/24.
//

import SwiftUI

struct SetAnswersView: View {
    @EnvironmentObject private var viewModel: MainViewVM
    
    @State private var playerIndex: Int = 0
    @State private var answer: String = ""
    @State private var playerName: String = ""
    @State private var emptyString: Bool = false
    @State private var nextPlayer: Bool = false
    @State private var popUp: Bool = false
    @State private var appState: AppState = .inGame
    
    @FocusState private var textEditorFocus: Bool
    
    
    var body: some View {
        let playersKeys: [String] = Array(viewModel.playersAndAnswers.keys)
        
            ZStack {
                VStack {
                    HeaderView()
                    
                    HStack {
                        Button {
                            viewModel.appState = .setPlayers
                        } label: {
                            Image(systemName: "chevron.left")
                                .fontWeight(.semibold)
                            Text("Volver a jugadores")
                        }
                        .font(.title3)
                        .fontWeight(.semibold)
                        .shadowPop()
                        .titleStyle()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 5)
                    
                    VStack(alignment: .center, spacing: 2) {
                        Text("Le toca responder a:")
                            .font(.headline)
                        
                        Text(playersKeys[playerIndex])
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
                    .padding([.top, .horizontal])
                    .shadowPop()
                    
                    VStack {
                        HStack {
                            Text("Para la pregunta:")
                                .font(.headline)
                            
                            Spacer()
                        }
                        
                        Text(viewModel.currentRandomQuestion)
                            .frame(maxWidth: .infinity)
                            .font(.title3)
                            .fontWeight(.heavy)
                            .padding(.horizontal)
                            .textInputAutocapitalization(.sentences)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 18)
                                    .foregroundStyle(.blue)
                                    .opacity(0.5)
                            }
                    }
                    .shadowPop()
                    .titleStyle()
                    .padding([.top, .horizontal])
                    
                    
                    VStack(alignment: .leading) {
                        Text("Responde sin que lo vean los demás:")
                            .font(.headline)
                            .shadowPop()
                        
                        TextEditor(text: $answer)
                            .frame(height: 150)
                            .font(.subheadline)
                            .foregroundStyle(.black)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.sentences)
                            .textEditorStyle(.automatic)
                            .focused($textEditorFocus)
                    }
                    .titleStyle()
                    .padding([.top, .horizontal])
                    
                    Spacer()
                    
                    if playerIndex != viewModel.numberOfPlayers - 1 {
                        Text("SIGUIENTE")
                            .primaryButton()
                            .onTapGesture {
                                if !answer.isEmpty {
                                    textEditorFocus = false
                                    viewModel.playersAndAnswers.updateValue(answer, forKey: playersKeys[playerIndex])
                                    answer = ""
                                    playerIndex += 1
                                    playerName = playersKeys[playerIndex]
                                    nextPlayer.toggle()
                                } else {
                                    emptyString.toggle()
                                }
                            }
                    } else {
                        Text("SIGUIENTE")
                            .primaryButton()
                            .onTapGesture {
                                withAnimation {
                                    if !answer.isEmpty {
                                        textEditorFocus = false
                                        viewModel.playersAndAnswers.updateValue(answer, forKey: playersKeys[playerIndex])
                                        viewModel.playerKeysInOrder = Array(viewModel.playersAndAnswers.keys)
                                        
                                        for answer in viewModel.playersAndAnswers.values {
                                            viewModel.rightAnswers.updateValue(false, forKey: answer)
                                        }
                                        
                                        for player in viewModel.playerKeysInOrder {
                                            if viewModel.playersScore.isEmpty {
                                                viewModel.setPlayerScoreTo0(player: player)
                                            }
                                        }
                                        
                                        answer = ""
                                        popUp.toggle()
                                    } else {
                                        emptyString.toggle()
                                    }
                                }
                            }
                    }
                }
                .background(BackgroundFinalView())
                .blur(radius: popUp || nextPlayer ? 2 : 0)
                .disabled(popUp || nextPlayer ? true : false)
                .onTapGesture {
                    textEditorFocus = false
                }
                .alert("La respuesta no puede estar vacía", isPresented: $emptyString) {}
                
                PopUpChangePlayer(title: "LE TOCA RESPONDER A:", playerName: $playerName, next: $nextPlayer, updateAnswer: .constant(false))
                    .opacity(nextPlayer ? 1.0 : 0.0)
                
                PopUpChangeAppState(title: "EMPEZAR JUEGO", buttonTitle: "JUGAR", appState: $appState)
                    .opacity(popUp ? 1.0 : 0.0)
                
            }
            .onAppear {
                if !viewModel.playingWithCustomQuestions {
                    repeat {
                        viewModel.currentRandomQuestion = viewModel.questions.randomElement() ?? ""
                    } while viewModel.questionsAlreadyAsked.contains(viewModel.currentRandomQuestion)
                } else {
                    repeat {
                        viewModel.currentRandomQuestion = viewModel.customQuestions.randomElement() ?? ""
                    } while viewModel.questionsAlreadyAsked.contains(viewModel.currentRandomQuestion)
                }
            }
    }
}
