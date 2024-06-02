//
//  SetAnswersView.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 14/5/24.
//

import SwiftUI

struct AddQuestionsView: View {
    @EnvironmentObject private var viewModel: MainViewVM
    
    @State private var playerIndex: Int = 0
    @State private var customQuestion: String = ""
    @State private var playerName: String = ""
    @State private var emptyString: Bool = false
    @State private var nextPlayer: Bool = false
    @State private var popUp: Bool = false
    @State private var appState: AppState = .setAnswers
    
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
                        Text(playersKeys[playerIndex])
                            .animation(.easeIn)
                            .font(.title3)
                        
                        Text("¡Añade una pregunta!")
                            .font(.headline)
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
                            Text("Pregunta de ejemplo:")
                                .font(.headline)
                            
                            Spacer()
                        }
                        
                        Text("\(viewModel.questions.randomElement() ?? "")")
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
                        Text("Escribe aquí tu pregunta:")
                            .font(.headline)
                            .shadowPop()
                        
                        TextEditor(text: $customQuestion)
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
                                if !customQuestion.isEmpty {
                                    textEditorFocus = false
                                    viewModel.customQuestions.append(customQuestion)
                                    customQuestion = ""
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
                                    if !customQuestion.isEmpty {
                                        textEditorFocus = false
                                        viewModel.playerKeysInOrder = Array(viewModel.playersAndAnswers.keys)
                                        viewModel.customQuestions.append(customQuestion)
                                        customQuestion = ""
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
                
                PopUpChangePlayer(title: "AÑADE UNA PREGUNTA", playerName: $playerName, next: $nextPlayer, updateAnswer: .constant(false))
                    .opacity(nextPlayer ? 1.0 : 0.0)
                
                PopUpChangeAppState(title: "¡YA QUEDA MENOS!\n\nTOCA RESPONDER", buttonTitle: "CONTINUAR", appState: $appState)
                    .opacity(popUp ? 1.0 : 0.0)
            }
    }
}

