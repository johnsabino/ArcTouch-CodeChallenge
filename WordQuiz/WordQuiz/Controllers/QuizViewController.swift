//
//  QuizViewController.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 13/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    let quizView = QuizView()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = quizView
    }

}
