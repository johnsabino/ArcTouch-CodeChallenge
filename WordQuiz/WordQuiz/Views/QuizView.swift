//
//  QuizView.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 13/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class QuizView: UIView {
    typealias Action = () -> Void
    private let titleLabel = UILabel(font: .title)
    private let textField = UITextField(cornerRadius: 10)
    private let tableView = UITableView()
    private let componentView = UIView()
    private let successRateLabel = UILabel(text: "00/50", font: .title)
    private let timerLabel = UILabel(text: "00:00", font: .title)
    private let actionButton = UIButton(title: "Start", cornerRadius: 10)
    
    var actionHandler: Action?
    weak var textFieldEditingDelegate: TextFieldEditingDelegate?
    
    init() {
        super.init(frame: .zero)
        
        setupView()
        tableView.register(UITableViewCell.self)
        tableView.allowsSelection = false
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        textFieldEditingDelegate?.textFieldDidChange(textField)
    }
    
    @objc private func actionButtonTapped() {
        actionButton.setTitle("Reset", for: .normal)
        actionHandler?()
    }
    
    func setTitle(text: String) {
        titleLabel.text = text
    }
    func setTableDataSource(_ dataSource: UITableViewDataSource) {
        tableView.dataSource = dataSource
    }
    
    func insertRow(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .right)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func updateTimerLabel(text: String) {
        timerLabel.text = text
    }
    
    func updateSuccessRateLabel(text: String) {
        successRateLabel.text = text
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

protocol TextFieldEditingDelegate: AnyObject {
    func textFieldDidChange(_ textField: UITextField)
}
