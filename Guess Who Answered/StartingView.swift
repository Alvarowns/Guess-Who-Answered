//
//  StartingView.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 13/5/24.
//

import SwiftUI

struct StartingView: View {
    @EnvironmentObject private var viewModel: MainViewVM
    
    var body: some View {
            VStack {
                HeaderView()
                
                InstructionsView()
                
                Spacer()
                
                Text("CONTINUAR")
                    .primaryButton()
                    .onTapGesture {
                        viewModel.appState = .setPlayers
                    }
            }
            .background(BackgroundFinalView())
    }
}

#Preview {
    StartingView()
        .environmentObject(MainViewVM())
}
