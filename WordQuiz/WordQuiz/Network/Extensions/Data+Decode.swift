//
//  Data+Decode.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 13/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation

extension Data {
    func decode<T: Decodable>(type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let model = try decoder.decode(T.self, from: self)
        return model
    }
}
