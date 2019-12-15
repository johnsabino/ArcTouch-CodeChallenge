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
    let timeLimit: TimeInterval //in seconds
    var quizStarted = false
    var correctAnswersCount: Int {
        return dataSource.correctAnswers.count
    }
    var allAnswersCount: Int {
        return dataSource.quiz.answer.count
    }
    
    weak var quizStatusDelegate: QuizStatusDelegate?
    
    init(timeLimit: TimeInterval = 300) {
        self.timeLimit = timeLimit
    }
    
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
        
    // MARK: - Quiz Logic
    
    /**
     Chech if the text is a valid answer.
     
     - parameter text: Input text
     - parameter hittedAnswerCompletion: if is a valid text, call the completion with the     
     answers count in correct format.
     - parameter countAnswers: The count of correct answers in format: NN/NN
    */
    func verify(text: String, hittedAnswerCompletion: (_ countAnswers: String) -> Void) {
        let answers = dataSource.quiz.answer
        let lowerCasedText = text.lowercased().trimmingCharacters(in: .whitespaces)
        let hitAnswer = answers.contains(lowerCasedText) &&
            !dataSource.correctAnswers.contains(lowerCasedText.firstUppercased)
        
        if hitAnswer {
            dataSource.correctAnswers.append(lowerCasedText.firstUppercased)
            
            let formattedCountAnswer = formatCountAnswer(correctAnswerCount: correctAnswersCount,
                                                 answersCount: allAnswersCount)
            
            hittedAnswerCompletion(formattedCountAnswer)
            
            if correctAnswersCount == allAnswersCount {
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
        quizStatusDelegate?.updateQuizStatus(to: .lose(correctAnswersCount: correctAnswersCount,
                                                       allAnswersCount: allAnswersCount))
    }
    
    private func endQuiz() {
        self.timer?.invalidate()
        self.timer = nil
        self.quizStarted = false
    }
}
