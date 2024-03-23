//
//  AuthenticationRouter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/15/24.
//

import UIKit

protocol AuthenticationRouterInput {
    func goToLoginScreen()
    func goToSignUpScreen()
}

final class AuthenticationRouter {
    
    private let viewController: AuthenticationViewController
    
    init(viewController: AuthenticationViewController) {
        self.viewController = viewController
    }
}

extension AuthenticationRouter: AuthenticationRouterInput {
    func goToLoginScreen() {
        let viewController = LoginBuilder.setupModule()
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func goToSignUpScreen() {
        let viewController = SignUpBuilder.setupModule()
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
