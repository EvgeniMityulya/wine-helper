//
//  MainRouter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/23/24.
//

import UIKit

protocol MainRouterInput {
    func goToLoginScreen()
    func goToSignUpScreen()
}

final class MainRouter {
    
    private let viewController: MainViewController
    
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
}

extension MainRouter: MainRouterInput {
    func goToLoginScreen() {
        let viewController = LoginBuilder.setupModule()
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func goToSignUpScreen() {
        let viewController = SignUpBuilder.setupModule()
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
