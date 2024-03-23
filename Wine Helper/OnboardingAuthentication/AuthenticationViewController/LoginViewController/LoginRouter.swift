//
//  LoginRouter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/15/24.
//

import UIKit

protocol LoginRouterInput {
    func goToNextScreen()
}

final class LoginRouter {
    
    private let viewController: LoginViewController
    
    init(viewController: LoginViewController) {
        self.viewController = viewController
    }
}

extension LoginRouter: LoginRouterInput {
    func goToNextScreen() {
        let viewController = AuthenticationBuilder.setupModule()
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
