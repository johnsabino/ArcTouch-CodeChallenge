//
//  QuizView.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 13/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class QuizView: UIView {
    lazy var titleLabel = UILabel(font: .title)
    let textField = UITextField(cornerRadius: 10)
    let tableView = UITableView()
    let componentView = UIView()
    let successRateLabel = UILabel(font: .title)
    let timerLabel = UILabel(font: .title)
    let actionButton = UIButton(cornerRadius: 10)
    
    override func didMoveToSuperview() {
        setupView()
        actionButton.setTitle("Reset", for: .normal)
        titleLabel.text = "What are all the java keywords?"
        successRateLabel.text = "07/50"
        timerLabel.text = "04:23"
    }
}

extension QuizView: ViewCode {
    func buildViewHierarchy() {
        addSubviews([titleLabel, textField, tableView, componentView])
        componentView.addSubviews([successRateLabel, timerLabel, actionButton])
    }
    
    func buildConstraints() {
        titleLabel.anchor
            .top(safeAreaLayoutGuide.topAnchor, padding: 24)
            .left(safeAreaLayoutGuide.leftAnchor, padding: 16)
            .right(safeAreaLayoutGuide.rightAnchor, padding: 16)
            
        textField.anchor
            .top(titleLabel.bottomAnchor, padding: 16)
            .left(safeAreaLayoutGuide.leftAnchor, padding: 16)
            .right(safeAreaLayoutGuide.rightAnchor, padding: 16)
            .height(constant: 48)
        
        tableView.anchor
            .top(textField.bottomAnchor)
            .left(safeAreaLayoutGuide.leftAnchor, padding: 16)
            .right(safeAreaLayoutGuide.rightAnchor, padding: 16)
        
        componentView.anchor
            .top(tableView.bottomAnchor)
            .left(safeAreaLayoutGuide.leftAnchor)
            .right(safeAreaLayoutGuide.rightAnchor)
            .bottom(safeAreaLayoutGuide.bottomAnchor)
        
        successRateLabel.anchor
            .top(componentView.topAnchor, padding: 16)
            .bottom(actionButton.topAnchor, padding: 16)
            .left(componentView.leftAnchor, padding: 16)
        
        timerLabel.anchor
            .top(componentView.topAnchor, padding: 16)
            .bottom(actionButton.topAnchor, padding: 16)
            .right(componentView.rightAnchor, padding: 16)
        
        actionButton.anchor
            .left(componentView.leftAnchor, padding: 16)
            .right(componentView.rightAnchor, padding: 16)
            .bottom(componentView.bottomAnchor, padding: 16)
            .height(constant: 48)
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .white
        componentView.backgroundColor = .customGray
    }
}
