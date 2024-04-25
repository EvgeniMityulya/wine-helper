//
//  OnboardingRouter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/25/24.
//

import UIKit

protocol OnboardingRouterInput {
    func navigateToMainScreen()
}

final class OnboardingRouter {
    
    private let viewController: OnboardingViewController
    
    init(viewController: OnboardingViewController) {
        self.viewController = viewController
    }
}

extension OnboardingRouter: OnboardingRouterInput {
    func navigateToMainScreen() {
        if let sceneDelegate = self.viewController.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkUserStatus()
        }
    }
}
