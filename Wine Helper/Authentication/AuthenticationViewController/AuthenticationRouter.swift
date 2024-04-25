//
//  AuthenticationRouter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/15/24.
//

import UIKit

protocol AuthenticationRouterInput {
    func navigateToLoginScreen()
    func navigateToSignUpScreen()
}

final class AuthenticationRouter {
    
    private let viewController: AuthenticationViewController
    
    init(viewController: AuthenticationViewController) {
        self.viewController = viewController
    }
}

extension AuthenticationRouter: AuthenticationRouterInput {
    func navigateToLoginScreen() {
        let viewController = LoginBuilder.setupModule()
        self.viewController.navigationController?.navigationBar.tintColor = UIColor.CustomColors.burgundy
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func navigateToSignUpScreen() {
        let viewController = SignUpBuilder.setupModule()
        self.viewController.navigationController?.navigationBar.tintColor = UIColor.CustomColors.burgundy
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
