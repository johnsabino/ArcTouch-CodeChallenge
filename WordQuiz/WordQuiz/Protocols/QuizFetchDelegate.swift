//
//  QuizFetchDelegate.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 14/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

protocol QuizFetchDelegate: AnyObject {
    func didSetQuiz()
    func didUpdateCorrectAnswers(isRestarting: Bool)
    func didFailFetch(with error: NetworkError)
}
