//
//  UIButton+Custom.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 13/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(cornerRadius: CGFloat) {
        self.init()
        layer.cornerRadius = cornerRadius
        backgroundColor = .customOrange
        titleLabel?.font = .button
    }
}
