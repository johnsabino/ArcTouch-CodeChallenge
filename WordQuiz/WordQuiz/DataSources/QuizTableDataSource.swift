//
//  QuizTableDataSource.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 14/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//
import UIKit

protocol QuizFetchDelegate: AnyObject {
    func didSetQuiz()
    func didUpdateCorrectAnswers(isHitted: Bool)
    func didFailFetch(with error: NetworkError)
}

class QuizTableDataSource: NSObject, UITableViewDataSource {
    
    weak var dataFetchDelegate: QuizFetchDelegate?
    var quiz: Quiz! {
        didSet {
            dataFetchDelegate?.didSetQuiz()
        }
    }
    var correctAnswers: [String] = [] {
        didSet {
            dataFetchDelegate?.didUpdateCorrectAnswers(isHitted: !correctAnswers.isEmpty)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return correctAnswers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.text = correctAnswers[indexPath.row]
        return cell
    }
}
