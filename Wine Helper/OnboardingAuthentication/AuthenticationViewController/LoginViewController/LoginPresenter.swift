//
//  LoginPresenter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/15/24.
//

import UIKit

protocol LoginViewOutput {
    func eyeButtonTapped()
    func loginButtonTouchDown(_ sender: UIButton)
    func loginButtonTouchUpInside(_ sender: UIButton)
    func loginButtonTouchUpOutside(_ sender: UIButton)
}

final class LoginPresenter: LoginViewOutput {
    
    private unowned let input: LoginViewInput
    private let router: LoginRouterInput
    
    init(input: LoginViewInput, router: LoginRouterInput) {
        self.input = input
        self.router = router
    }
    
    func eyeButtonTapped() {
        input.changeEyeButtonImage()
    }
    
    func loginButtonTouchDown(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 0.8)
    }
    
    func loginButtonTouchUpInside(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 1)
        
        guard let userRequest = input.getLoginUserRequest() else {
            print("Пожалуйста, заполните все поля.")
            return
        }
        
        FirebaseManager.shared.signIn(with: userRequest) { error in
            if let error = error {
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
}
