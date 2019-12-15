//
//  UITableView+DequeueCell.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 14/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

// swiftlint:disable force_cast

import UIKit

extension UITableView {
    func register<T: AnyObject>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: "\(T.self)")
    }
    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as! T
    }
}
