//
//  Quiz.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 13/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

struct Quiz: Decodable {
    let question: String
    var answer: [String]
}
