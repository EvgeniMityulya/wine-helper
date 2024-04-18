//
//  LoginPresenter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/15/24.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

protocol LoginViewOutput {
    func eyeButtonTapped()
    func loginButtonTouchDown(_ sender: UIButton)
    func loginButtonTouchUpInside(_ parent: UIViewController, _ sender: UIButton)
    func loginButtonTouchUpOutside(_ sender: UIButton)
    func loginGoogleButtonTouchUpInside(_ sender: UIButton)
}

final class LoginPresenter: LoginViewOutput {
    
    private unowned let input: LoginViewInput
    private let router: LoginRouterInput
    let parentViewController: LoginViewController
    
    init(parent: LoginViewController, input: LoginViewInput, router: LoginRouterInput) {
        self.parentViewController = parent
        self.input = input
        self.router = router
    }
    
    func eyeButtonTapped() {
        input.changeEyeButtonImage()
    }
    
    func loginButtonTouchDown(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 0.8)
    }
    
    func loginButtonTouchUpInside(_ parent: UIViewController, _ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 1)
        
        guard let userRequest = input.getLoginUserRequest() else {
            print("Пожалуйста, заполните все поля.")
            return
        }
        
        FirebaseManager.shared.signInEmail(with: userRequest) { error in
            if let error = error {
                TextValidationManager.shared.showAlert(vc: parent, with: "Log In Error", message: "Invalid Email or password")
                print(error.localizedDescription)
                return
            }
            
            self.input.checkAuth()
            print("Login success")
        }
    }
    
    func loginButtonTouchUpOutside(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 1)
    }
    
    func loginGoogleButtonTouchUpInside(_ sender: UIButton) {
        guard let idToken = UserDefaultsManager.idToken,
              let userAccessToken = UserDefaultsManager.userAccessToken
        else {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }

            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config

            
            GIDSignIn.sharedInstance.signIn(withPresenting: self.parentViewController) { result, error in
                if let error = error {
                    print("Ошибка аутентификации через Google: \(error.localizedDescription)")
                    return
                }
                
                FirebaseManager.shared.registerUserGoogle(with: result) { isRegistered, error in
                    if let error = error  {
                        print(error.localizedDescription)
                        return
                    }
                    
                    self.input.checkAuth()
                    print("Registered success")
                }
            }
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: userAccessToken)
        
        FirebaseManager.shared.logUserInWithGoogle(credential: credential) { _, error in
            if let error = error {
                TextValidationManager.shared.showAlert(vc: self.parentViewController, with: "Log In Error", message: "Log In Undefined Error")
                print(error.localizedDescription)
                return
            }
            
            self.input.checkAuth()
            print("Login success")
        }
    }
}
