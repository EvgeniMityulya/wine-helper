//
//  NextViewController.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/9/24.
//

import UIKit


protocol AuthenticationViewInput: AnyObject {
    func changeButtonBackgroundColorWithAlpha(_ sender: UIButton, color: UIColor, alpha: CGFloat)
}

final class AuthenticationViewController: UIViewController {
    
    var output: AuthenticationViewOutput?
    
    private lazy var topIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Image.Registration.topIconWine)
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Wine Helper"
        label.font = UIFont.openSans(ofSize: 24, style: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.backgroundColor = UIColor.CustomColors.background
        label.textColor = UIColor.CustomColors.text
        label.layer.zPosition = 5
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "We will help you choose a wine based on your preferences!"
        label.font = UIFont.openSans(ofSize: 18, style: .semiBold)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.backgroundColor = UIColor.CustomColors.background
        label.textColor = UIColor.CustomColors.text
        label.layer.zPosition = 5
        return label
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.titleLabel?.font = UIFont.openSans(ofSize: 19, style: .regular)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        button.backgroundColor = UIColor.CustomColors.burgundy
        button.addTarget(self, action: #selector(logInButtonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(logInButtonTouchUpInside), for: .touchUpInside)
        button.addTarget(self, action: #selector(logInButtonTouchUpOutside), for: .touchUpOutside)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.CustomColors.buttonWhiteTextColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.titleLabel?.font = UIFont.openSans(ofSize: 19, style: .regular)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.CustomColors.burgundy.cgColor
        button.layer.masksToBounds = true
        
//        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(signUpButtonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(signUpButtonTouchUpInside), for: .touchUpInside)
        button.addTarget(self, action: #selector(signUpButtonTouchUpOutside), for: .touchUpOutside)
        return button
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.CustomColors.background
        self.setupUI()
    }
}

extension AuthenticationViewController: AuthenticationViewInput {
    func changeButtonBackgroundColorWithAlpha(_ sender: UIButton, color: UIColor, alpha: CGFloat) {
        sender.backgroundColor = color.withAlphaComponent(alpha)
    }
}

private extension AuthenticationViewController {
    @objc private func logInButtonTouchDown() {
        output?.loginButtonTouchDown(logInButton)
    }
    
    @objc private func logInButtonTouchUpInside() {
        output?.loginButtonTouchUpInside(logInButton)
    }
    
    @objc private func logInButtonTouchUpOutside() {
        output?.loginButtonTouchUpOutside(logInButton)
    }
    
    @objc private func signUpButtonTouchDown() {
        output?.signUpButtonTouchDown(signUpButton)
    }
    
    @objc private func signUpButtonTouchUpInside() {
        output?.signUpButtonTouchUpInside(signUpButton)
    }
    
    @objc private func signUpButtonTouchUpOutside() {
        output?.signUpButtonTouchUpOutside(signUpButton)
    }
}

private extension AuthenticationViewController {
    func setupUI() {
        self.view.addSubview(self.topIconImageView)
        self.view.addSubview(self.signUpButton)
        self.view.addSubview(self.logInButton)
        self.view.addSubview(self.subtitleLabel)
        self.view.addSubview(self.titleLabel)
        
        NSLayoutConstraint.activate([
            self.topIconImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 44),
            self.topIconImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.topIconImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.topIconImageView.heightAnchor.constraint(equalToConstant: 300),
            
            self.signUpButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            self.signUpButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.signUpButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 44),
            
            self.logInButton.bottomAnchor.constraint(equalTo: self.signUpButton.topAnchor, constant: -16),
            self.logInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.logInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.logInButton.heightAnchor.constraint(equalToConstant: 44),
            
            self.subtitleLabel.bottomAnchor.constraint(equalTo: self.logInButton.topAnchor, constant: -30),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.subtitleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            self.titleLabel.bottomAnchor.constraint(equalTo: self.subtitleLabel.topAnchor, constant: 0),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
