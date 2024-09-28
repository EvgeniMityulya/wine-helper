//
//  LoginRouter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/15/24.
//

import UIKit

protocol LoginRouterInput {
    func navigateToOnboardingScreen()
}

final class LoginRouter {
    
    private let viewController: LoginViewController
    
    init(viewController: LoginViewController) {
        self.viewController = viewController
    }
}

extension LoginRouter: LoginRouterInput {
    func navigateToOnboardingScreen() {
        if let sceneDelegate = self.viewController.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkUserStatus()
        }
    }
}
