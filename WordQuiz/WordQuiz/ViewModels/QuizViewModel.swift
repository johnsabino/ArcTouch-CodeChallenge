//
//  QuizViewModel.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 13/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

struct QuizViewModel {
    let dataSource = QuizTableDataSource()
    
    func getQuiz(id: Int = 1) {
        let apiProvider = APIProvider<Quiz>()
        apiProvider.request(EndPoint.getQuiz(id: id)) { result in
            switch result {
            case .success(let response):
                self.dataSource.data = response
            case.failure(let error):
                self.dataSource.dataFetchDelegate?.didFailFetch(with: error)
            }
        }
    }
}
