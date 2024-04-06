//
//  LoginViewController.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/9/24.
//

import UIKit

protocol LoginViewInput: AnyObject, Authentication {
    func changeEyeButtonImage()
    func changeButtonBackgroundColorWithAlpha(_ sender: UIButton, color: UIColor, alpha: CGFloat)
    func getLoginUserRequest() -> (LoginUserRequest)?
}

final class LoginViewController: UIViewController, Authentication {
    
    var output: LoginViewOutput?
    
    var passwordTextFieldBottomConstraint: NSLayoutConstraint?
    
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
        imageView.image = SystemImage.envelope.image
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var passwordImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = SystemImage.lock.image
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var mailTextField: UITextField = {
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
        showHideButton.setImage(SystemImage.eyeSlash.image, for: .normal)
        showHideButton.setImage(SystemImage.eye.image, for: .selected)
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
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        button.backgroundColor = UIColor.CustomColors.burgundy
        button.addTarget(self, action: #selector(loginButtonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(loginButtonTouchUpInside), for: .touchUpInside)
        button.addTarget(self, action: #selector(loginButtonTouchUpOutside), for: .touchUpOutside)
        return button
    }()
    
    private lazy var appleLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue with Apple", for: .normal)
        button.setTitleColor(UIColor.CustomColors.text, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        if let appleLogoImage = SystemImage.applelogo.image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)) {
            button.setImage(appleLogoImage, for: .normal)
        }
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        
        return button
    }()
    
    private lazy var googleLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue with Google", for: .normal)
        button.setTitleColor(UIColor.CustomColors.text, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        if let googleIconImage = UIImage(named: Image.Registration.googleIcon)  {
            let scaledGoogleIconImage = googleIconImage.scaledToFit(size: CGSize(width: 30, height: 30))
            button.setImage(scaledGoogleIconImage, for: .normal)
        }
        button.contentMode = .scaleAspectFit
        
        
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
        label.backgroundColor = UIColor.CustomColors.background
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
        self.view.backgroundColor = UIColor.CustomColors.background
        self.setupUI()
        self.setupDelegates()
        self.setupNotificactionCenterObservers()
        self.setupGestureRecognizers()
    }
    
    private func setupNotificactionCenterObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func setupDelegates() {
        self.mailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let keyboardHeight = keyboardFrame.height
        
        UIView.animate(withDuration: 0.3) {
            self.passwordTextFieldBottomConstraint?.constant = -keyboardHeight
            self.passwordTextFieldBottomConstraint?.isActive = true
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.passwordTextFieldBottomConstraint?.isActive = false
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}


extension LoginViewController: LoginViewInput {
    func changeEyeButtonImage() {
        passwordTextField.isSecureTextEntry.toggle()
        if let showHideButton = passwordTextField.rightView as? UIButton {
            showHideButton.isSelected = !showHideButton.isSelected
            
            if passwordTextField.isSecureTextEntry {
                showHideButton.setImage(SystemImage.eyeSlash.image, for: .normal)
            } else {
                showHideButton.setImage(SystemImage.eye.image, for: .normal)
            }
        }
    }
    
    func changeButtonBackgroundColorWithAlpha(_ sender: UIButton, color: UIColor, alpha: CGFloat) {
        sender.backgroundColor = color.withAlphaComponent(alpha)
    }
    
    func getLoginUserRequest() -> (LoginUserRequest)? {
        guard let mail = mailTextField.text,
              let password = passwordTextField.text,
              !mail.isEmpty,
              !password.isEmpty
        else {
            return nil
        }
        return LoginUserRequest(email: mail, password: password)
    }
    
    func checkAuth() {
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkAuthentication()
        }
    }
}

private extension LoginViewController {
    @objc private func loginButtonTouchDown() {
        output?.loginButtonTouchDown(loginButton)
    }
    
    @objc private func loginButtonTouchUpInside() {
        output?.loginButtonTouchUpInside(loginButton)
    }
    
    @objc private func loginButtonTouchUpOutside() {
        output?.loginButtonTouchUpOutside(loginButton)
    }
    
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        output?.eyeButtonTapped()
    }
}

private extension LoginViewController {
    func setupUI() {
        self.view.addSubview(
            self.topIconImageView,
            self.mailImageView,
            self.passwordImageView,
            self.mailTextField,
            self.passwordTextField,
            self.loginButton,
            self.separatorLabel,
            self.separatorView,
            self.appleLoginButton,
            self.googleLoginButton
        )
        
        passwordTextFieldBottomConstraint = passwordTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        
        NSLayoutConstraint.activate([
            self.topIconImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.topIconImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.topIconImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.topIconImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 300),
            
            self.mailImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.mailImageView.widthAnchor.constraint(equalToConstant: 30),
            self.mailImageView.heightAnchor.constraint(equalToConstant: 30),
            self.mailImageView.centerYAnchor.constraint(equalTo: self.mailTextField.centerYAnchor, constant: 2),
            
            self.passwordImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.passwordImageView.widthAnchor.constraint(equalToConstant: 30),
            self.passwordImageView.heightAnchor.constraint(equalToConstant: 30),
            self.passwordImageView.centerYAnchor.constraint(equalTo: self.passwordTextField.centerYAnchor, constant: 2),
            
            self.mailTextField.topAnchor.constraint(equalTo: self.topIconImageView.bottomAnchor, constant: 20),
            self.mailTextField.leadingAnchor.constraint(equalTo: self.mailImageView.trailingAnchor, constant: 20),
            self.mailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.mailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            self.passwordTextField.topAnchor.constraint(equalTo: self.mailTextField.bottomAnchor, constant: 5),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.passwordImageView.trailingAnchor, constant: 20),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            self.loginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 20),
            self.loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            self.loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            self.loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            self.separatorLabel.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 20),
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
