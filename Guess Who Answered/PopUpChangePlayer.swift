//
//  GameOverView.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 21/5/24.
//

import SwiftUI
import ConfettiSwiftUI

struct PopUpChangePlayer: View {
    @EnvironmentObject private var viewModel: MainViewVM
    
    @State var title: String
    @Binding var playerName: String
    @Binding var next: Bool
    @Binding var updateAnswer: Bool
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.5)
                .shadowPop()
                .titleStyle()
                
            VStack(spacing: 30) {
                Text(title)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .shadowPop()
                    .titleStyle()
                
                Text(playerName)
                    .font(.largeTitle)
                    .shadowPop()
                    .titleStyle()
                
                Text("CONTINUAR")
                    .primaryButton()
                    .onTapGesture {
                        next.toggle()
                        updateAnswer.toggle()
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
    PopUpChangePlayer(title: "LE TOCA JUGAR A:", playerName: .constant("Ale"), next: .constant(false), updateAnswer: .constant(false))
        .environmentObject(MainViewVM())
}

