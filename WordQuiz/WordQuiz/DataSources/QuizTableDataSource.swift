//
//  QuizTableDataSource.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 14/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//
import UIKit

protocol DataFetchDelegate: AnyObject {
    func didSetData()
    func didFailFetch(with: NetworkError)
}

class QuizTableDataSource: NSObject, UITableViewDataSource {
    
    weak var dataFetchDelegate: DataFetchDelegate?
    var data: Quiz! {
        didSet {
            dataFetchDelegate?.didSetData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.text = "Else"
        return cell
    }
}
