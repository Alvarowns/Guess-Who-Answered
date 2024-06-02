//
//  InstructionsView.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 28/5/24.
//

import SwiftUI

struct InstructionsView: View {
    @EnvironmentObject private var viewModel: MainViewVM
    
    @State private var scrollAtEnd: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 10) {
                        Text("INSTRUCCIONES")
                            .font(.largeTitle)
                        
                        Text("En Guess Who Answered los jugadores responden a una o varias preguntas sin que nadie sepa qué han respondido, entonces, por turnos, los jugadores tendrán que adivinar de quién es la respuesta que les ha tocado, ganando, o no, puntos en el proceso.")
                    }
                    
                    VStack(spacing: 10) {
                        Text("PASOS")
                            .font(.title)
                        
                        VStack(spacing: 25) {
                            Group {
                                HStack(alignment: .top) {
                                    Text("1.")
                                    Text("Añadimos los jugadores.\n¡Cuantos más mejor!")
                                }
                                
                                HStack(alignment: .top) {
                                    Text("2.")
                                    Text("Elegimos jugar con preguntas predefinidas o ¡con nuestras propias preguntas!")
                                }
                                
                                HStack(alignment: .top) {
                                    Text("3.")
                                    Text("Si hemos elegido nuestras preguntas cada jugador, por orden, tendrá que añadir una pregunta.\n¿Quién será el más ingenioso?\n\nEn caso contrario el juego proporcionará sus propias preguntas.")
                                }
                                
                                HStack(alignment: .top) {
                                    Text("4.")
                                    Text("Cada jugador, por orden y sin que lo vean los demás, responderá una de las preguntas.\n\nEste proceso se repetirá por cada pregunta añadida.")
                                }
                                
                                HStack(alignment: .top) {
                                    Text("5.")
                                    Text("¡A JUGAR!\n\nSaldrá una pregunta, un jugador y una respuesta aleatoria.\n\nEl jugador elegido tendrá que LEER EN VOZ ALTA LA PREGUNTA Y LA RESPUESTA e intentar adivinar de quién es la respuesta para dicha pregunta, también en voz alta.\n\n· En caso de acertar se le sumará 1 punto a ese jugador y la respuesta no aparecerá más durante el juego.\n\n· En caso de no acertar no se sumarán ni restarán puntos.\n\nEn ambos casos, acaba la ronda de ese jugador y tiene que pasar el móvil al siguiente jugador que sale en pantalla.")
                                }
                                
                                HStack(alignment: .top) {
                                    Text("6.")
                                    Text("Una vez que se hayan acertado todas las respuestas se repetirá el juego con la siguiente pregunta.\n\nCuando no queden más preguntas el juego termina y pasaremos a los RESULTADOS.")
                                }
                                
                                Text("¿Quién conocerá mejor a sus amigos?")
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, alignment: .center)
                        }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                        }
                    }
                }
            }
            .scrollIndicators(.never)
            
            if !scrollAtEnd {
                Image(systemName: "chevron.down")
                    .titleStyle()
                    .padding(.top, 5)
            }
        }
        .frame(maxWidth: .infinity)
        .font(.title3)
        .fontWeight(.heavy)
        .textInputAutocapitalization(.sentences)
        .multilineTextAlignment(.center)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 18)
                .foregroundStyle(.blue)
                .opacity(0.5)
        }
        .shadowPop()
        .titleStyle()
        .padding()
    }
}

#Preview {
    InstructionsView()
        .environmentObject(MainViewVM())
}
