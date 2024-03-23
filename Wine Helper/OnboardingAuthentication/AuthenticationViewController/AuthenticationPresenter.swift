//
//  AuthenticationPresenter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/15/24.
//


import UIKit

protocol AuthenticationViewOutput {
    func loginButtonTouchDown(_ sender: UIButton)
    func loginButtonTouchUpInside(_ sender: UIButton)
    func loginButtonTouchUpOutside(_ sender: UIButton)
    
    func signUpButtonTouchDown(_ sender: UIButton)
    func signUpButtonTouchUpInside(_ sender: UIButton)
    func signUpButtonTouchUpOutside(_ sender: UIButton)
}

final class AuthenticationPresenter: AuthenticationViewOutput {
    private unowned let input: AuthenticationViewInput
    private let router: AuthenticationRouterInput
    
    init(input: AuthenticationViewInput, router: AuthenticationRouterInput) {
        self.input = input
        self.router = router
    }
    
    func loginButtonTouchDown(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 0.8)
    }
    
    func loginButtonTouchUpInside(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 1)
        router.goToLoginScreen()
    }
    
    func loginButtonTouchUpOutside(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 1)
    }
    
    func signUpButtonTouchDown(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.systemGray4, alpha: 0.8)
    }
    
    func signUpButtonTouchUpInside(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.background, alpha: 1)
        router.goToSignUpScreen()
    }
    
    func signUpButtonTouchUpOutside(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.background, alpha: 1)
    }
}
