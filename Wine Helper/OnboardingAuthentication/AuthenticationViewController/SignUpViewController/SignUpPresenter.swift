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
        
        guard let userRequest = input.getRegisterUserRequest() else {
            print("Пожалуйста, заполните все поля.")
            return
        }
        
        FirebaseManager.shared.registerUser(with: userRequest) { isRegistered, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.input.checkAuth()
            print("Registered success")
        }

    }
    
    func signUpButtonTouchUpOutside(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 1)
    }
}
