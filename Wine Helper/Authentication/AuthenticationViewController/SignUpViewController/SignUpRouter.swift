//
//  SignUpRouter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/17/24.
//

import UIKit

protocol SignUpRouterInput {
    func navigateToOnboardingScreen()
}

final class SignUpRouter {
    
    private let viewController: SignUpViewController
    
    init(viewController: SignUpViewController) {
        self.viewController = viewController
    }
}

extension SignUpRouter: SignUpRouterInput {
    func navigateToOnboardingScreen() {
        if let sceneDelegate = self.viewController.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkUserStatus()
        }
    }
}
