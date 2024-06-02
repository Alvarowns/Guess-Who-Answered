//
//  BackgroundFinalView.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 22/5/24.
//

import SwiftUI

struct BackgroundFinalView: View {
    var body: some View {
        Image(.fondoMovilAvataresCute)
            .resizable()
            .scaledToFill()
            .opacity(0.85)
    }
}

#Preview {
    BackgroundFinalView()
}
