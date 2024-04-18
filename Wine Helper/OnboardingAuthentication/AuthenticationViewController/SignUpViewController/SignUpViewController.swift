//
//  SignUpViewController.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/17/24.
//

import UIKit

protocol SignUpViewInput: AnyObject, Authentication {
    func changeEyeButtonImage()
    func changeButtonBackgroundColorWithAlpha(_ sender: UIButton, color: UIColor, alpha: CGFloat)
    func getRegisterUserRequest() -> (RegisterUserRequest)?
}

final class SignUpViewController: UIViewController {
    
    var output: SignUpViewOutput?
    var currentNonce: String?
    
    var passwordTextFieldBottomConstraint: NSLayoutConstraint?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = contentView.bounds.size
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.CustomColors.background
        return view
    }()
    
    private lazy var topIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Image.Registration.topIconWine)
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var usernameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = SystemImage.person.image
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
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField.textFieldWithInsets(insets: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        textField.setUnderLine()
        textField.placeholder = "Username"
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var mailTextField: UITextField = {
        let textField = UITextField.textFieldWithInsets(insets: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        textField.setUnderLine()
        textField.placeholder = "Email"
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField.textFieldWithInsets(insets: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        textField.setUnderLine()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
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
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        button.backgroundColor = UIColor.CustomColors.burgundy
        button.addTarget(self, action: #selector(signUpButtonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(signUpButtonTouchUpInside), for: .touchUpInside)
        button.addTarget(self, action: #selector(signUpButtonTouchUpOutside), for: .touchUpOutside)
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
        
        button.addTarget(self, action: #selector(signUpAppleButtonTouchUpInside), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var googleLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue with Google", for: .normal)
        button.setTitleColor(UIColor.CustomColors.text, for: .normal)
        
//        button.setImage(UIImage(named: Image.Registration.googleIcon), for: .normal)
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
        
        button.addTarget(self, action: #selector(signUpGoogleButtonTouchUpInside), for: .touchUpInside)
        
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
    
    deinit {
        self.removeNotificactionCenterObservers()
    }
    
    private func setupNotificactionCenterObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeNotificactionCenterObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func setupDelegates() {
        self.usernameTextField.delegate = self
        self.mailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
}

extension SignUpViewController: SignUpViewInput {
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
    
    func getRegisterUserRequest() -> (RegisterUserRequest)? {
        guard let username = usernameTextField.text,
              let mail = mailTextField.text,
              let password = passwordTextField.text,
              !username.isEmpty,
              !mail.isEmpty,
              !password.isEmpty
        else {
            return nil
        }
        return RegisterUserRequest(username: username, email: mail, password: password)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        
        self.scrollView.contentInset.bottom = keyboardHeight
    }
    
    
    @objc func keyboardWillHide(_ notification: Notification) {
        self.scrollView.contentInset = .zero
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

private extension SignUpViewController {
    @objc private func signUpButtonTouchDown() {
        output?.signUpButtonTouchDown(signUpButton)
    }
    
    @objc private func signUpButtonTouchUpInside() {
        output?.signUpButtonTouchUpInside(signUpButton)
    }
    
    @objc private func signUpButtonTouchUpOutside() {
        output?.signUpButtonTouchUpOutside(signUpButton)
    }
    
    @objc private func signUpGoogleButtonTouchUpInside() {
        output?.signUpGoogleButtonTouchUpInside(googleLoginButton)
    }
    
    @objc private func signUpAppleButtonTouchUpInside() {
        output?.signUpAppleButtonTouchUpInside(appleLoginButton)
    }
    
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        output?.eyeButtonTapped()
    }
}

private extension SignUpViewController {
    func setupUI() {
        self.view.addSubview(
            self.scrollView
        )
        
        self.scrollView.addSubview(
            self.contentView
        )
        
        self.contentView.addSubview(
            self.topIconImageView,
            self.usernameImageView,
            self.usernameTextField,
            self.mailImageView,
            self.passwordImageView,
            self.mailTextField,
            self.passwordTextField,
            self.signUpButton,
            self.separatorLabel,
            self.separatorView,
            self.appleLoginButton,
            self.googleLoginButton
        )
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor),
            
            self.topIconImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.topIconImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.topIconImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.topIconImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            
            self.usernameImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.usernameImageView.widthAnchor.constraint(equalToConstant: 30),
            self.usernameImageView.heightAnchor.constraint(equalToConstant: 30),
            self.usernameImageView.centerYAnchor.constraint(equalTo: self.usernameTextField.centerYAnchor, constant: 2),
            
            self.mailImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.mailImageView.widthAnchor.constraint(equalToConstant: 30),
            self.mailImageView.heightAnchor.constraint(equalToConstant: 30),
            self.mailImageView.centerYAnchor.constraint(equalTo: self.mailTextField.centerYAnchor, constant: 2),
            
            self.passwordImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.passwordImageView.widthAnchor.constraint(equalToConstant: 30),
            self.passwordImageView.heightAnchor.constraint(equalToConstant: 30),
            self.passwordImageView.centerYAnchor.constraint(equalTo: self.passwordTextField.centerYAnchor, constant: 2),
            
            self.usernameTextField.topAnchor.constraint(equalTo: self.topIconImageView.bottomAnchor, constant: 20),
            self.usernameTextField.leadingAnchor.constraint(equalTo: self.usernameImageView.trailingAnchor, constant: 20),
            self.usernameTextField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            self.mailTextField.topAnchor.constraint(equalTo: self.usernameTextField.bottomAnchor, constant: 5),
            self.mailTextField.leadingAnchor.constraint(equalTo: self.mailImageView.trailingAnchor, constant: 20),
            self.mailTextField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.mailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            self.passwordTextField.topAnchor.constraint(equalTo: self.mailTextField.bottomAnchor, constant: 5),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.passwordImageView.trailingAnchor, constant: 20),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            
            self.signUpButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 20),
            self.signUpButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30),
            self.signUpButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -30),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 40),
            
            self.separatorLabel.topAnchor.constraint(equalTo: self.signUpButton.bottomAnchor, constant: 20),
            self.separatorLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.separatorLabel.widthAnchor.constraint(equalToConstant: 50),
            self.separatorLabel.heightAnchor.constraint(equalToConstant: 20),
            
            self.separatorView.centerYAnchor.constraint(equalTo: self.separatorLabel.centerYAnchor),
            self.separatorView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.separatorView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            
            self.appleLoginButton.topAnchor.constraint(equalTo: self.separatorLabel.bottomAnchor, constant: 20),
            self.appleLoginButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30),
            self.appleLoginButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -30),
            self.appleLoginButton.heightAnchor.constraint(equalToConstant: 40),
            
            self.googleLoginButton.topAnchor.constraint(equalTo: self.appleLoginButton.bottomAnchor, constant: 10),
            self.googleLoginButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30),
            self.googleLoginButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -30),
            self.googleLoginButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            self.googleLoginButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
        ])
        
    }
}
