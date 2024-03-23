//
//  SignUpPresenter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/17/24.
//

import UIKit
import Firebase

protocol SignUpViewOutput {
    func eyeButtonTapped()
    func signUpButtonTouchDown(_ sender: UIButton)
    func signUpButtonTouchUpInside(_ sender: UIButton)
    func signUpButtonTouchUpOutside(_ sender: UIButton)
}

final class SignUpPresenter: SignUpViewOutput {
    
    private unowned let input: SignUpViewInput
    private let router: SignUpRouterInput
    
    init(input: SignUpViewInput, router: SignUpRouterInput) {
        self.input = input
        self.router = router
    }
    
    func eyeButtonTapped() {
        input.changeEyeButtonImage()
    }
    
    func signUpButtonTouchDown(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 0.8)
    }
    
    func signUpButtonTouchUpInside(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 1)
        
        guard let (username, mail) = input.getUsernameAndMail() else {
            print("Пожалуйста, заполните все поля.")
            return
        }
        
//        Auth.auth().fetchSignInMethods(forEmail: mail) { (methods, error) in
//            if let error = error {
//                print("Error fetching sign-in methods: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let methods = methods else {
//                print("No sign-in methods available.")
//                return
//            }
//            
//            if methods.contains(EmailAuthProviderID) {
//                // Адрес электронной почты уже зарегистрирован
//                print("Email already registered. Please sign in.")
//                return
//            }
//            
//            // Отправляем ссылку аутентификации на электронную почту
//            sendSignInLink(to: mail, withUsername: username)
//            print("Sign-in link sent to email: \(mail)")
//        }
    }
    
    func signUpButtonTouchUpOutside(_ sender: UIButton) {
        print(3)
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 1)
    }
}
