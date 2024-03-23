//
//  SignUpPresenter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/17/24.
//

import UIKit

protocol SignUpViewOutput {
    func eyeButtonTapped()
    func loginButtonTouchDown(_ sender: UIButton)
    func loginButtonTouchUpInside(_ sender: UIButton)
    func loginButtonTouchUpOutside(_ sender: UIButton)
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
    
    func loginButtonTouchDown(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 0.8)
    }
    
    func loginButtonTouchUpInside(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 1)
    }
    
    func loginButtonTouchUpOutside(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 1)
    }
}
