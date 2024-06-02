//
//  GameOverView.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 21/5/24.
//

import SwiftUI

struct PopUpChangeAppStateBetweenTwo: View {
    @EnvironmentObject private var viewModel: MainViewVM
    
    @State var title: String
    @State var buttonTitle1: String
    @State var buttonTitle2: String
    
    @Binding var appState1: AppState
    @Binding var appState2: AppState
    @Binding var playingWithCustomQuestionIsTrue: Bool
    @Binding var playingWithCustomQuestionIsFalse: Bool
    
    @Binding var focusState: Bool
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.5)
                .shadowPop()
                .titleStyle()
                
            VStack {
                Text(title)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .shadowPop()
                    .titleStyle()
                
                VStack {
                    HStack {
                        Text(buttonTitle1)
                            .primaryButton()
                            .onTapGesture {
                                viewModel.appState = appState1
                                viewModel.playingWithCustomQuestions = playingWithCustomQuestionIsTrue
                            }
                        
                        Spacer()
                        
                        Text(buttonTitle2)
                            .primaryButton()
                            .onTapGesture {
                                viewModel.appState = appState2
                                viewModel.playingWithCustomQuestions = playingWithCustomQuestionIsFalse
                            }
                    }
                }
                .padding(.vertical, 5)
                
                Text("Espera, ¡aún no he terminado!")
                    .primaryButtonCancel()
                    .onTapGesture {
                        focusState.toggle()
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 250)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(2)
        .background {
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.white)
                
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 3)
                    .foregroundStyle(.white)
            }
        }
        .padding(.horizontal)
        .shadowPop()
        .titleStyle()
    }
}

#Preview {
    PopUpChangeAppStateBetweenTwo(title: "ELIGE UNA", buttonTitle1: "SCORES", buttonTitle2: "ANSWERS", appState1: .constant(.scores), appState2: .constant(.setAnswers), playingWithCustomQuestionIsTrue: .constant(true), playingWithCustomQuestionIsFalse: .constant(false), focusState: .constant(false))
        .environmentObject(MainViewVM())
}

