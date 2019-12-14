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
    let quizViewModel = QuizViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        quizViewModel.getQuiz()
    }
    
    func setupDataSource() {
        quizViewModel.dataSource.dataFetchDelegate = self
        quizView.tableView.dataSource = quizViewModel.dataSource
    }
    
    override func loadView() {
        view = quizView
    }
}

extension QuizViewController: DataFetchDelegate {
    func didSetData() {

    }
    
    func didFailFetch(with: NetworkError) {
        
    }
}
