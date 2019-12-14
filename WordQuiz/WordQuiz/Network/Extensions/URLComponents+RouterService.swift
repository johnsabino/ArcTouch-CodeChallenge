//
//  URLComponents+RouterService.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 13/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation

extension URLComponents {
    init(endPoint: RouterService) {
        let baseURL = URL(string: endPoint.baseURL)
        let url = baseURL?.appendingPathComponent(endPoint.path)
        // swiftlint:disable force_unwrapping
        self.init(url: url!, resolvingAgainstBaseURL: false)!
    }
}
