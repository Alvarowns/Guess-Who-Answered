//
//  AddPlayers.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 14/5/24.
//

import SwiftUI

struct AddPlayers: View {
    @Binding var playerName: String
    let playerPrompt: String
    
    var body: some View {
        TextField(playerPrompt, text: $playerName)
            .textInputAutocapitalization(.words)
            .autocorrectionDisabled()
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .padding()
            .background {
                Capsule()
                    .foregroundStyle(.white)
                    .shadow(color: .gray, radius: 2, x: 0, y: 1)
            }
            .padding(.horizontal)
    }
}

#Preview {
    AddPlayers(playerName: .constant(""), playerPrompt: "Jugador 1")
}
