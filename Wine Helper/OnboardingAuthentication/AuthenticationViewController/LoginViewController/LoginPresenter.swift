//
//  LoginPresenter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/15/24.
//

import Foundation

protocol LoginViewOutput {
//    func logInButtonTa
}

final class LoginPresenter: LoginViewOutput {
    
    private unowned let input: LoginViewInput
    private let router: LoginRouterInput
    
    init(input: LoginViewInput, router: LoginRouterInput) {
        self.input = input
        self.router = router
    }
}

