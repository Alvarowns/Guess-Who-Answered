//
//  Extensions.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 13/5/24.
//

import SwiftUI

extension Text {
    func primaryButton() -> some View {
        self
            .frame(maxWidth: .infinity)
            .font(.title3)
            .bold()
            .padding(.horizontal)
            .brightness(0.1)
            .foregroundStyle(.black)
            .bold()
            .padding()
            .background {
                Capsule()
                    .padding(.horizontal)
                    .foregroundStyle(Gradient(colors: [.yellow, .orange]))
                    .brightness(0.1)
            }
            .shadow(radius: 0.4)
            .shadow(radius: 0.4)
            .shadow(radius: 0.4, y: 0.5)
            .shadow(radius: 0.4, y: 0.5)
            .shadow(radius: 0.4, y: 0.5)
    }
    
    func primaryButtonCancel() -> some View {
        self
            .frame(maxWidth: .infinity)
            .font(.title3)
            .bold()
            .padding(.horizontal)
            .brightness(0.1)
            .foregroundStyle(.white)
            .bold()
            .padding()
            .background {
                Capsule()
                    .tint(.black)
                    .padding(.horizontal)
                    .foregroundStyle(Gradient(colors: [.red, .red.opacity(0.8), .red.opacity(0.5)]))
                    .brightness(0.1)
            }
            .shadow(radius: 0.4)
            .shadow(radius: 0.4)
            .shadow(radius: 0.4, y: 0.5)
            .shadow(radius: 0.4, y: 0.5)
            .shadow(radius: 0.4, y: 0.5)
            .padding(.top, 10)
    }
}

extension View {
    func titleStyle() -> some View {
        self
            .font(.largeTitle)
            .bold()
            .shadow(color: .gray, radius: 2, x: 0, y: 1)
            .foregroundStyle(Gradient(colors: [.yellow, .orange]))
            .shadow(radius: 0.4)
            .shadow(radius: 0.4)
            .shadow(radius: 0.4, y: 0.5)
            .shadow(radius: 0.4, y: 0.5)
            .shadow(radius: 0.4, y: 0.5)
    }
    
    func shadowPop() -> some View {
        self
            .shadow(radius: 0.9)
            .shadow(radius: 0.9)
            .shadow(radius: 0.9, y: 0.5)
            .shadow(radius: 0.9, y: 0.5)
            .shadow(radius: 0.9, y: 0.5)
    }
}

