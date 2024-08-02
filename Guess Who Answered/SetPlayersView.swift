//
//  SetPlayersView.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 14/5/24.
//

import SwiftUI

struct SetPlayersView: View {
    @EnvironmentObject private var viewModel: MainViewVM
    
    @State private var sheetPresented: Bool = false
    @State private var noPlayersAlert: Bool = false
    @State private var twoPlayersAlert: Bool = false
    @State private var popUp: Bool = false
    
    @State private var appState1: AppState = .addQuestions
    @State private var appState2: AppState = .setAnswers
    
    @FocusState private var textEditorFocus: Bool
    
    var body: some View {
            ZStack {
                VStack {
                    HeaderView()
                    
                    HStack {
                        Button {
                            viewModel.appState = .startingView
                        } label: {
                            Image(systemName: "chevron.left")
                                .fontWeight(.semibold)
                            Text("Volver a las instrucciones")
                        }
                        .font(.title3)
                        .fontWeight(.semibold)
                        .shadowPop()
                        .titleStyle()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 5)
                    
                    HStack {
                        Spacer()
                        Spacer()
                        
                        Text("Añadir jugador")
                        
                        Spacer()
                        
                        Image(systemName: "plus")
                            .shadowPop()
                            .foregroundStyle(.white)
                            .padding(2)
                            .background {
                                Circle()
                                    .foregroundStyle(Gradient(colors: [.yellow, .orange]))
                            }
                            .onTapGesture {
                                sheetPresented.toggle()
                            }
                            .padding(.trailing, 5)
                    }
                    .shadowPop()
                    .shadowPop()
                    .titleStyle()
                    .padding([.top, .horizontal])
                    
                    ScrollView {
                            LazyVStack {
                                ForEach(Array(viewModel.playersAndAnswers.sorted(by: {$0.key < $1.key})), id: \.key) { name, answer in
                                    HStack {
                                        PlayerButton(playerName: name, playerSelected: .constant(""))
                                        
                                        Image(systemName: "trash.circle.fill")
                                            .renderingMode(.original)
                                            .shadowPop()
                                            .font(.largeTitle)
                                            .onTapGesture {
                                                withAnimation(.spring) {
                                                    viewModel.deletePlayerDictionary(player: name)
                                                }
                                            }
                                    }
                                }
                            }
                    }
                    .padding()
                    
                    Text("CONTINUAR")
                        .primaryButton()
                        .onTapGesture {
                            if viewModel.playersAndAnswers.keys.count >= 3 {
                                viewModel.numberOfPlayers = viewModel.playersAndAnswers.keys.count
                                popUp.toggle()
                            } else if viewModel.playersAndAnswers.keys.count == 2 {
                                twoPlayersAlert.toggle()
                            } else {
                                noPlayersAlert.toggle()
                            }
                        }

                    Spacer()
                }
                .background(BackgroundFinalView())
                .blur(radius: popUp ? 2 : 0)
                .disabled(popUp ? true : false)
                .onTapGesture {
                    textEditorFocus = false
                }
                .sheet(isPresented: $sheetPresented) {
                    AddPlayersSheet(sheetPresented: $sheetPresented)
                }
                .alert("¿Vas a jugar sólo?\nAñade más jugadores, anda...", isPresented: $noPlayersAlert) {}
                .alert("¡Entre dos no tiene gracia!\nAñade más jugadores, anda...", isPresented: $twoPlayersAlert) {}
                
                PopUpChangeAppStateBetweenTwo(
                    title: NSLocalizedString("¿QUIERES AÑADIR TUS PROPIAS PREGUNTAS?", comment: "Prompt for adding custom questions"),
                    buttonTitle1: NSLocalizedString("Añadir", comment: "Add"),
                    buttonTitle2: NSLocalizedString("Saltar", comment: "Skip"),
                    appState1: $appState1,
                    appState2: $appState2,
                    playingWithCustomQuestionIsTrue: .constant(true),
                    playingWithCustomQuestionIsFalse: .constant(false),
                    focusState: $popUp
                )
                    .opacity(popUp ? 1.0 : 0.0)
            }
    }
}

#Preview {
    SetPlayersView()
        .environmentObject(MainViewVM())
}
