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
    private lazy var titleLabel = UILabel(font: .title)
    private lazy var textField = UITextField(cornerRadius: 10)
    private lazy var tableView = UITableView()
    private let componentView = UIView()
    private let correctAnswersCountLabel = UILabel(text: "00/50", font: .title)
    private let timerLabel = UILabel(text: "05:00", font: .title)
    private let actionButton = UIButton(title: "Start", cornerRadius: 10)
    
    var bottomConstraint: NSLayoutConstraint?
    var actionHandler: Action?
    weak var textFieldEditingDelegate: TextFieldEditingDelegate?
    
    init() {
        super.init(frame: .zero)
        setupView()
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        setupKeyboardObservers()
        textField.delegate = self
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
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

    func setupTableView(dataSource: UITableViewDataSource) {
        tableView.dataSource = dataSource
        tableView.register(UITableViewCell.self)
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
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
    
    func updateCorrectAnswersCountLabel(text: String) {
        correctAnswersCountLabel.text = text
    }
    
    // MARK: - Keyboard Observers
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardSize = notification.userInfo?  [UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            else { return }

        let keyboardHeight = keyboardSize.height
        let padding: CGFloat = 16
        let newConstant = -(keyboardHeight - safeAreaInsets.bottom + padding)
        animateBottomConstraint(to: newConstant)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        animateBottomConstraint(to: -16)
    }
    
    private func animateBottomConstraint(to constant: CGFloat) {
        self.bottomConstraint?.constant = constant
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
}

// MARK: - View Code
extension QuizView: ViewCode {
    func buildViewHierarchy() {
        addSubviews([titleLabel, textField, tableView, componentView])
        componentView.addSubviews([correctAnswersCountLabel, timerLabel, actionButton])
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
            .left(leftAnchor)
            .right(rightAnchor)
            .bottom(bottomAnchor)
        
        correctAnswersCountLabel.anchor
            .top(componentView.topAnchor, padding: 16)
            .bottom(actionButton.topAnchor, padding: 16)
            .left(safeAreaLayoutGuide.leftAnchor, padding: 16)
        
        timerLabel.anchor
            .top(componentView.topAnchor, padding: 16)
            .bottom(actionButton.topAnchor, padding: 16)
            .right(safeAreaLayoutGuide.rightAnchor, padding: 16)
        
        bottomConstraint = actionButton.anchor
            .left(safeAreaLayoutGuide.leftAnchor, padding: 16)
            .right(safeAreaLayoutGuide.rightAnchor, padding: 16)
            .height(constant: 48)
            .bottom(safeAreaLayoutGuide.bottomAnchor, padding: 16).getLastConstraint
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .white
        componentView.backgroundColor = .customGray
    }
}

extension QuizView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
