//
//  AuthenticationPresenter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/15/24.
//


import Foundation

protocol AuthenticationViewOutput {
    func logInButtonTapped()
    func signUpButtonTapped()
}

final class AuthenticationPresenter: AuthenticationViewOutput {
    private unowned let input: AuthenticationViewInput
    private let router: AuthenticationRouterInput
    
    init(input: AuthenticationViewInput, router: AuthenticationRouterInput) {
        self.input = input
        self.router = router
    }
    
    func logInButtonTapped() {
        self.router.goToNextScreen()
    }
    
    func signUpButtonTapped() {
        self.router.goToNextScreen()
    }
}
