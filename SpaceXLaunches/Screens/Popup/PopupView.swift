//
//  PopupView.swift
//  SpaceXLaunches
//
//  Created by Sarp  on 7.02.2022.
//

import UIKit

class PopupView: UIView {
    
    let containerView = UIView()
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    let button = UIButton()
    
    let padding: CGFloat = 20
    
    var dissmissViewController: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(_ text: String) {
        messageLabel.text = text
    }

    private func setup() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setupContainerView()
        setupTitleLabel()
        setupMessageLabel()
        setupButton()
    }
    
    private func setupContainerView() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.text = "Warning"
        titleLabel.textAlignment = .center
    }
    
    private func setupMessageLabel() {
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.text = "Error"
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
    }
    
    private func setupButton() {
        button.setTitle("OK", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 18).isActive = true
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    @objc func dismissViewController() {
        self.dissmissViewController?()
    }
    
    private func setupLayout() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(messageLabel)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(button)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            button.heightAnchor.constraint(equalToConstant: 44),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -12)
        ])
    }
}
