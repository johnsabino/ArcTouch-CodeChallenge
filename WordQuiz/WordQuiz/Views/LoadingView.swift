//
//  LoadingView.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 14/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    lazy var view = UIView()
    lazy var loadingIndicator = UIActivityIndicatorView()
    lazy var loadingLabel = UILabel(text: "Loading...", font: .button)
    
    override func didMoveToSuperview() {
        setupView()
        loadingIndicator.startAnimating()
    }
}

extension LoadingView: ViewCode {
    func buildViewHierarchy() {
        addSubview(view)
        view.addSubviews([loadingIndicator, loadingLabel])
    }
    
    func buildConstraints() {
        guard let superView = superview else { return}
        
        anchor.attatch(to: superView)
        
        view.anchor
            .centerX(centerXAnchor)
            .centerY(centerYAnchor)
        
        loadingIndicator.anchor
            .top(view.topAnchor, padding: 32)
            .centerX(centerXAnchor)

        loadingLabel.anchor
            .top(loadingIndicator.bottomAnchor, padding: 32)
            .left(view.leftAnchor, padding: 48)
            .right(view.rightAnchor, padding: 48)
            .bottom(view.bottomAnchor, padding: 16)
    }
    
    func setupAditionalConfiguration() {
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 10
        loadingIndicator.color = .white
        loadingIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        loadingLabel.textColor = .white
        
        backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.4)
    }
}
