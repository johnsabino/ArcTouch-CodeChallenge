//
//  EndPoint.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 13/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation

enum EndPoint {
    case getQuiz(id: Int)
}

extension EndPoint: RouterService {
    var baseURL: String {
        return "https://codechallenge.arctouch.com"
    }
    
    var path: String {
        switch self {
        case .getQuiz(let id):
            return "/quiz/\(id)"
        }
    }  
}
