//
//  GameOverView.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 21/5/24.
//

import SwiftUI

struct PopUpChangeAppState: View {
    @EnvironmentObject private var viewModel: MainViewVM
    
    @State var title: String
    @State var buttonTitle: String
    
    @Binding var appState: AppState
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.5)
                .shadowPop()
                .titleStyle()
                
            VStack(spacing: 80) {
                Text(title)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .shadowPop()
                    .titleStyle()
                
                Text(buttonTitle)
                    .primaryButton()
                    .onTapGesture {
                        viewModel.appState = appState
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
        .padding()
        .shadowPop()
        .titleStyle()
    }
}

#Preview {
    PopUpChangeAppState(title: "JUEGO TERMINADO", buttonTitle: "RESULTADOS", appState: .constant(.scores))
        .environmentObject(MainViewVM())
}
