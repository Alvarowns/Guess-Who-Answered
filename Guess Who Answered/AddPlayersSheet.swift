//
//  addPlayersSheet.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 14/5/24.
//

import SwiftUI

struct AddPlayersSheet: View {
    @EnvironmentObject private var viewModel: MainViewVM
    
    @State private var emptyString: Bool = false
    @State private var playerNameAlreadyExists: Bool = false
    
    @State private var player: String = ""
    
    @Binding var sheetPresented: Bool
    
    var body: some View {
            ZStack {
                Color.pink.opacity(0.6)
                    .ignoresSafeArea()
                
                VStack {
                    AddPlayers(playerName: $player, playerPrompt: "Jugador \(viewModel.numberOfPlayers + 1)")
                    
                    Text("Añadir")
                        .primaryButton()
                        .onTapGesture {
                            if !viewModel.playersAndAnswers.contains(where: {$0.key == player}) {
                                if !player.isEmpty {
                                    viewModel.playersAndAnswers.updateValue("", forKey: player)
                                    player = ""
                                    viewModel.numberOfPlayers += 1
                                    sheetPresented.toggle()
                                }
                            } else {
                                playerNameAlreadyExists.toggle()
                            }
                        }
                }
            }
            .presentationDetents([.fraction(0.21)])
            .alert("El nombre no puede estar vacío", isPresented: $emptyString) {}
            .alert("Ya hay un jugador con ese nombre", isPresented: $playerNameAlreadyExists) {}
    }
}

#Preview {
    AddPlayersSheet(sheetPresented: .constant(false))
        .environmentObject(MainViewVM())
}
