//
//  QuizViewModelTests.swift
//  WordQuizTests
//
//  Created by João Paulo de Oliveira Sabino on 14/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import XCTest
@testable import WordQuiz

class QuizViewModelTests: XCTestCase {

    var quizViewModel: QuizViewModel!

    override func setUp() {
        quizViewModel = QuizViewModel(timeLimit: 1)
        let quiz = Quiz(question: "What are all the java keywords?",
                        answer: ["do", "catch"])
        quizViewModel.dataSource.quiz = quiz
    }

    override func tearDown() {
        quizViewModel = nil
    }

    func testSetTimer_success() {
        let expectation = XCTestExpectation(description: "Correct Word")
        
        quizViewModel.setTimer { _ in
            expectation.fulfill()
        }
        XCTAssertNotNil(quizViewModel.timer)
        wait(for: [expectation], timeout: 2)
    }
    
    func testVerifyCorrectAnswer() {
        let expectation = XCTestExpectation(description: "Correct Word")
        
        quizViewModel.verify(text: "Do") {  _ in
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testVerifyIncorrectAnswer() {
        quizViewModel.verify(text: "None") { (_) in
            XCTFail("Should not enter here, because the word is not correct")
        }
    }
    
    func testWinQuiz() {
        quizViewModel.verify(text: "do") { (_) in }
        quizViewModel.verify(text: "catch") { (_) in }
        
        let correctAnswersCount = quizViewModel.dataSource.correctAnswers.count
        let allAnswerCount = quizViewModel.dataSource.quiz.answer.count
        XCTAssertEqual(correctAnswersCount, allAnswerCount)
    }
    
    func testLoseQuiz() {
        let expectation = XCTestExpectation(description: "Lose the game after time ends.")
        var count = 1
        
        quizViewModel.setTimer { _ in
            count -= 1
            if count == -1 {
                expectation.fulfill()
            }
        }
        quizViewModel.verify(text: "do") { (_) in }
        
        let correctAnswersCount = quizViewModel.dataSource.correctAnswers.count
        let allAnswerCount = quizViewModel.dataSource.quiz.answer.count
        XCTAssertLessThan(correctAnswersCount, allAnswerCount)
        
        wait(for: [expectation], timeout: 5)
    }

}
