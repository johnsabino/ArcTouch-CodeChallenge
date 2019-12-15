//
//  TextFieldEditingDelegate.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 14/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

protocol TextFieldEditingDelegate: AnyObject {
    func textFieldDidChange(_ textField: UITextField)
}
