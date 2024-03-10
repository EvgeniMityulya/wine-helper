//
//  ViewController.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/9/24.
//

import UIKit

final class AuthenticationViewController: UIViewController {
    
    private lazy var segmentControl: UISegmentedControl = {
        let items = ["Login", "Register"]
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        return segmentControl
    }()
    
    private lazy var topIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Image.Registration.topIconWine)
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var mailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "envelope")
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var passwordImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "lock")
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField.textFieldWithInsets(insets: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        textField.setUnderLine()
        textField.placeholder = "Email"
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField.textFieldWithInsets(insets: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        textField.setUnderLine()
        textField.placeholder = "Password"
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        
        let showHideButton = UIButton(type: .custom)
        showHideButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        showHideButton.setImage(UIImage(systemName: "eye"), for: .selected)
        showHideButton.tintColor = .lightGray
        showHideButton.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(actionButtonTapped(_:)), for: .touchUpInside)
        button.setBackgroundColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var appleLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Continue with Apple", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setBackgroundColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        if let appleLogoImage = UIImage(systemName: "applelogo", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)) {
            button.setImage(appleLogoImage, for: .normal)
        }
        button.imageView?.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        
        return button
    }()
    
    private lazy var googleLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Continue with Google", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setBackgroundColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        if let googleIconImage = UIImage(named: "googleIcon") {
            let scaledGoogleIconImage = googleIconImage.scaledToFit(size: CGSize(width: 20, height: 20))
            button.setImage(scaledGoogleIconImage, for: .normal)
        }
        button.imageView?.contentMode = .scaleAspectFit
        
        
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        
        return button
    }()
    
    
    
    private lazy var separatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "or"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = .systemGray
        label.layer.zPosition = 5
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}

private extension AuthenticationViewController {
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        print("Selected segment index: \(sender.selectedSegmentIndex)")
        
        let title = sender.selectedSegmentIndex == 0 ? "Login" : "Register"
        loginButton.setTitle(title, for: .normal)
    }
    
    @objc func actionButtonTapped(_ sender: UIButton) {
        let actionTitle = sender.titleLabel?.text ?? ""
        print("Action button tapped: \(actionTitle)")
    }
    
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        sender.isSelected = !sender.isSelected
        
        if passwordTextField.isSecureTextEntry {
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
}

private extension AuthenticationViewController {
    
}

private extension AuthenticationViewController {
    func setupUI() {
        self.view.addSubview(self.segmentControl)
        self.view.addSubview(self.topIconImageView)
        self.view.addSubview(self.mailImageView)
        self.view.addSubview(self.passwordImageView)
        self.view.addSubview(self.usernameTextField)
        self.view.addSubview(self.passwordTextField)
        self.view.addSubview(self.loginButton)
        self.view.addSubview(self.separatorLabel)
        self.view.addSubview(self.separatorView)
        self.view.addSubview(self.appleLoginButton)
        self.view.addSubview(self.googleLoginButton)
        
        NSLayoutConstraint.activate([
            self.topIconImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.topIconImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.topIconImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.topIconImageView.heightAnchor.constraint(equalToConstant: 300),
            
            self.segmentControl.topAnchor.constraint(equalTo: self.topIconImageView.bottomAnchor, constant: 25),
            self.segmentControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.segmentControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            self.mailImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.mailImageView.widthAnchor.constraint(equalToConstant: 30),
            self.mailImageView.heightAnchor.constraint(equalToConstant: 30),
            self.mailImageView.centerYAnchor.constraint(equalTo: self.usernameTextField.centerYAnchor, constant: 2),
            
            self.passwordImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.passwordImageView.widthAnchor.constraint(equalToConstant: 30),
            self.passwordImageView.heightAnchor.constraint(equalToConstant: 30),
            self.passwordImageView.centerYAnchor.constraint(equalTo: self.passwordTextField.centerYAnchor, constant: 2),
            
            self.usernameTextField.topAnchor.constraint(equalTo: self.segmentControl.bottomAnchor, constant: 20),
            self.usernameTextField.leadingAnchor.constraint(equalTo: self.mailImageView.trailingAnchor, constant: 20),
            self.usernameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            self.passwordTextField.topAnchor.constraint(equalTo: self.usernameTextField.bottomAnchor, constant: 5),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.passwordImageView.trailingAnchor, constant: 20),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            self.loginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 20),
            self.loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            self.loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            self.loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            self.separatorLabel.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 10),
            self.separatorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.separatorLabel.widthAnchor.constraint(equalToConstant: 50),
            
            self.separatorView.centerYAnchor.constraint(equalTo: self.separatorLabel.centerYAnchor),
            self.separatorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.separatorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            
            self.appleLoginButton.topAnchor.constraint(equalTo: self.separatorLabel.bottomAnchor, constant: 20),
            self.appleLoginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            self.appleLoginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            self.appleLoginButton.heightAnchor.constraint(equalToConstant: 40),
            
            self.googleLoginButton.topAnchor.constraint(equalTo: self.appleLoginButton.bottomAnchor, constant: 10),
            self.googleLoginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            self.googleLoginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            self.googleLoginButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
    }
}
