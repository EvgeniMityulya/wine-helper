//
//  AuthenticationRouter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/15/24.
//

import UIKit

protocol AuthenticationRouterInput {
    func goToNextScreen()
}

final class AuthenticationRouter {
    
    private let viewController: AuthenticationViewController
    
    init(viewController: AuthenticationViewController) {
        self.viewController = viewController
    }
}

extension AuthenticationRouter: AuthenticationRouterInput {
    func goToNextScreen() {
        let viewController = LoginBuilder.setupModule()
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
