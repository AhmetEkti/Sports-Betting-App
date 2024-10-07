//
//  EmptyStateView.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/4/24.
//

import UIKit

class EmptyStateView: UIView {
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16
        return stack
    }()
    
    private let symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(stackView)
        stackView.addArrangedSubview(symbolImageView)
        stackView.addArrangedSubview(messageLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            symbolImageView.widthAnchor.constraint(equalToConstant: 60),
            symbolImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setMessage(_ message: String, symbolName: String) {
        messageLabel.text = message
        symbolImageView.image = UIImage(systemName: symbolName)?.withRenderingMode(.alwaysTemplate)
    }
}
