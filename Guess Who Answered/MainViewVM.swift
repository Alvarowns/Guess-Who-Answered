//
//  MainViewVM.swift
//  Guess Who Answered
//
//  Created by Alvaro Santos Orellana on 13/5/24.
//

import Foundation

@Observable
class MainViewVM: ObservableObject {
    var appState: AppState = .splash
    
    var numberOfPlayers: Int = 0
    var numberOfQuestionsAnswered: Int = 1
    var currentIndex: Int = 0
    var currentQuestionIndex: Int = 0
    var questionIndicesAlreadyShown: [Int] = []
    var playersAndAnswers: [String: String] = [:]
    var playerKeysInOrder: [String] = []
    var playersScore: [String: Int] = [:]
    var rightAnswers: [String: Bool] = [:]
    var playingWithCustomQuestions: Bool = false
    var customQuestions: [String] = []
    var questions: [String] = []
    var currentRandomQuestion: String = ""
    var questionsAlreadyAsked: [String] = []
    
    init() {
        do {
            self.questions = try getQuestions()
        } catch {
            print(error)
        }
    }
    
    func getQuestions() throws -> [String] {
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else { return [] }
        let data = try Data(contentsOf: url)
        
        return try JSONDecoder().decode([String].self, from: data)
    }
    
    func deletePlayerDictionary(player: String) {
        self.playersAndAnswers.removeValue(forKey: player)
        if playersScore.contains(where: { $0.key == player }) {
            self.playersScore.removeValue(forKey: player)
        }
        
        guard numberOfPlayers > 0 else { return }
        self.numberOfPlayers -= 1
    }
    
    func setPlayerScoreTo0(player: String) {
        playersScore.updateValue(0, forKey: player)
    }
    
    func ifEveryAnswerIsTrueThenUpdateNumberOfQestionAnswered() {
        if rightAnswers.values.allSatisfy({$0 == true}) {
            self.numberOfQuestionsAnswered += 1
        }
    }
    
    func updatePlayerScore(player: String) {
        let currentScore = playersScore[player] ?? 0
        let newScore = currentScore + 1
        playersScore.updateValue(newScore, forKey: player)
    }
    
    func selectQuestion() -> String? {
        guard !questions.isEmpty || !customQuestions.isEmpty else { return nil }
        
        if !customQuestions.isEmpty {
            while currentQuestionIndex < customQuestions.count - 1 {
                var randomQuestion = ""
                var index = 0
                
                repeat {
                    index = customQuestions.indices.randomElement() ?? 0
                } while questionIndicesAlreadyShown.contains(index)
                
                currentQuestionIndex += 1
                questionIndicesAlreadyShown.append(index)
                
                randomQuestion = customQuestions[index]
                
                return randomQuestion
            }
        } else {
            // return question random de questions predefinidas
        }
        
        return nil
    }
    
    func questionsAlreadyAsked(question: String) {
        self.questionsAlreadyAsked.append(question)
    }
    
    
    func selectNextPlayerAndRandomAnswer() -> (player: String, answer: String)? {
        guard !playerKeysInOrder.isEmpty else { return nil }
        
        while currentIndex < playerKeysInOrder.count {
            let randomAnswer = ""
            let currentPlayerKey = playerKeysInOrder[currentIndex]
            let currentPlayerValue = playersAndAnswers[currentPlayerKey] ?? ""
            
            currentIndex += 1
            
            if !rightAnswers.values.allSatisfy({ $0 == true }) {
                let falseAnswers = playersAndAnswers.values.filter { answer in
                    !(rightAnswers[answer] ?? true)
                }
                
                if !falseAnswers.isEmpty {
                    var randomAnswer = ""
                    if falseAnswers.count == 1 && falseAnswers.contains(currentPlayerValue) {
                        randomAnswer = currentPlayerValue
                    } else {
                        repeat {
                            randomAnswer = falseAnswers.randomElement() ?? ""
                        } while randomAnswer == currentPlayerValue
                    }
                    
                    return (player: currentPlayerKey, answer: randomAnswer)
                }
            }
            
            return (player: currentPlayerKey, answer: randomAnswer)
        }
        
        if rightAnswers.values.contains(false) {
            currentIndex = 0
            return selectNextPlayerAndRandomAnswer()
        }
        
        return nil
    }
}
