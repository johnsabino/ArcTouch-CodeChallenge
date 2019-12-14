//
//  Encodable+Data.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 13/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation

extension Encodable {
    var dataValue: Data? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        return try? jsonEncoder.encode(self)
    }
}
