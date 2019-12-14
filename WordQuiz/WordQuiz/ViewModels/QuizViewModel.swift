//
//  QuizViewModel.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 13/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//
import Foundation

class QuizViewModel {
    let dataSource = QuizTableDataSource()
    var timer: Timer?
    let timeLimit: TimeInterval = 300 //in seconds
    var hasCompleted = false
    var quizStarted = false
    var correctAnswersCount: Int {
        return dataSource.correctAnswers.count
    }
    
    weak var quizStatusDelegate: QuizStatusDelegate?
    
    func getQuiz(id: Int) {
        let apiProvider = APIProvider<Quiz>()
        apiProvider.request(EndPoint.getQuiz(id: id)) { result in
            switch result {
            case .success(let response):
                self.dataSource.quiz = response
            case.failure(let error):
                self.dataSource.dataFetchDelegate?.didFailFetch(with: error)
            }
        }
    }
    
    func verify(text: String, hittedAnswerCompletion: (_ countAnswers: String) -> Void) {
        let answers = dataSource.quiz.answer
        let lowerCasedText = text.lowercased().trimmingCharacters(in: .whitespaces)
        let hitAnswer = answers.contains(lowerCasedText) &&
            !dataSource.correctAnswers.contains(lowerCasedText.firstUppercased)
        if hitAnswer {
            dataSource.correctAnswers.append(lowerCasedText.firstUppercased)
            
            let correctAnswerCount = dataSource.correctAnswers.count
            let allAnswersCount = answers.count
            let formattedCountAnswer = formatCountAnswer(correctAnswerCount: correctAnswerCount,
                                                 answersCount: allAnswersCount)
            
            hittedAnswerCompletion(formattedCountAnswer)
            
            if correctAnswerCount == allAnswersCount {
                self.winQuiz()
            }   
        }
    }
    
    private func formatCountAnswer(correctAnswerCount: Int, answersCount: Int) -> String {
        let zero = correctAnswerCount < 10 ? "0" : ""
        return "\(zero)\(correctAnswerCount)/\(answersCount)"
    }
    
    func setTimer(completion: @escaping (_ currentTime: String) -> Void) {
        endQuiz()
        dataSource.correctAnswers = []
        quizStarted = true
        var seconds = timeLimit
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
               
            guard let self = self else { return }
            let formattedDuration = formatter.string(from: seconds) ?? ""
            completion(formattedDuration)
            seconds -= 1
                        
            if seconds <= -1 {
                self.loseQuiz()
            }
        })
    }
    
    private func winQuiz() {
        endQuiz()
        quizStatusDelegate?.updateQuizStatus(to: .win)
    }
    
    private func loseQuiz() {
        endQuiz()
        let correctAnswersCount = dataSource.correctAnswers.count
        let allAnswersCount = dataSource.quiz.answer.count
        quizStatusDelegate?.updateQuizStatus(to: .lose(correctAnswersCount: correctAnswersCount,
                                                       allAnswersCount: allAnswersCount))
    }
    
    private func endQuiz() {
        self.timer?.invalidate()
        self.timer = nil
        self.quizStarted = false
    }
}
