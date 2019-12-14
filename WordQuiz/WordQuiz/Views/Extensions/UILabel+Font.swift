//
//  UILabel+Font.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 13/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String? = nil, font: UIFont?) {
        self.init()
        self.text = text
        self.font = font
        numberOfLines = 0
    }
}
