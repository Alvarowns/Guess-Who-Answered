//
//  GameFinishedView.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 13/5/24.
//

import SwiftUI

struct ScoresView: View {
    @EnvironmentObject private var viewModel: MainViewVM
    
    var body: some View {
        VStack {
            HeaderView()
            
            Text("PUNTUACIÓN")
                .titleStyle()
                .padding()
            
            ScrollView {
                ForEach(Array(viewModel.playersScore.sorted(by: {$0.value > $1.value})), id: \.key) { player, score in
                    HStack {
                        if score == viewModel.playersScore.values.max() {
                            Image(systemName: "crown.fill")
                                .opacity(score == viewModel.playersScore.values.max() ? 1.0 : 0.0)
                                .foregroundStyle(.yellow)
                                .shadow(radius: 0.1)
                        } else if score == viewModel.playersScore.values.min() {
                            Text("👎🏻")
                        } else {
                            Image(systemName: "crown.fill")
                                .opacity(0.0)
                        }
                        Text(player)
                        Spacer()
                        Text("\(score)")
                    }
                    .font(.headline)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.white)
                    }
                    .shadowPop()
                    .padding(.horizontal)
                }
            }
            
            Spacer()
            
            Text("VOLVER A JUGAR")
                .primaryButton()
                .onTapGesture {
                    viewModel.appState = .setPlayers
                }
        }
        .background(BackgroundFinalView())
        .onAppear {
            viewModel.numberOfQuestionsAnswered = 1
        }
    }
}

#Preview {
    ScoresView()
        .environmentObject(MainViewVM())
}
