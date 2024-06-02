//
//  Guess_Who_AnsweredApp.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 13/5/24.
//

import SwiftUI

@main
struct Guess_Who_AnsweredApp: App {
    @StateObject private var viewModel = MainViewVM()
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .environmentObject(MainViewVM())
    }
}
