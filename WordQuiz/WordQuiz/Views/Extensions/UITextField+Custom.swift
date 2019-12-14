//
//  UITextField+Custom.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 13/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

extension UITextField {
    convenience init(cornerRadius: CGFloat) {
        self.init()
        layer.cornerRadius = cornerRadius
        backgroundColor = .customGray
        placeholder = "Insert Word"
        font = .body
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
}
