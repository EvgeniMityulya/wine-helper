//
//  SignUpRouter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/17/24.
//

import UIKit

protocol SignUpRouterInput {
    func goToNextScreen()
}

final class SignUpRouter {
    
    private let viewController: SignUpViewController
    
    init(viewController: SignUpViewController) {
        self.viewController = viewController
    }
}

extension SignUpRouter: SignUpRouterInput {
    func goToNextScreen() {
        let viewController = AuthenticationBuilder.setupModule()
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
