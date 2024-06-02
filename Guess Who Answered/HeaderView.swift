//
//  HeaderView.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 13/5/24.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        Text("Guess Who Answered")
            .font(.largeTitle)
            .bold()
            .foregroundStyle(.yellow)
            .brightness(0.1)
            .shadow(color: .blue, radius: 1, x: 2, y: 2)
    }
}

#Preview {
    SetPlayersView()
        .environmentObject(MainViewVM())
}
