//
//  PlayerButton.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 13/5/24.
//

import SwiftUI

struct PlayerButton: View {
    @State var playerName: String = ""
    @Binding var playerSelected: String
    
    var body: some View {
        Text(playerName)
            .font(.title3)
            .lineLimit(1)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .padding()
            .background {
                Capsule()
                    .foregroundStyle(playerSelected == playerName ? .yellow : .white)
                    .shadow(color: .gray, radius: 1, x: 0, y: 1)
            }
            .onTapGesture {
                playerSelected = playerName
            }
    }
}

#Preview {
    PlayerButton(playerSelected: .constant(""))
}
