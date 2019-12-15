//
//  QuizStatusDelegate.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 14/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation

enum QuizStatus {
    case win
    case lose(correctAnswersCount: Int, allAnswersCount: Int)
}
protocol QuizStatusDelegate: AnyObject {
    func updateQuizStatus(to status: QuizStatus)
}
