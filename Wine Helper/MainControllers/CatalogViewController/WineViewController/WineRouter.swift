//
//  WineRouter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/13/24.
//

import UIKit

protocol WineRouterInput {
    func goToLoginScreen()
    func goToSignUpScreen()
}

final class WineRouter {
    
    private let viewController: WineViewController
    
    init(viewController: WineViewController) {
        self.viewController = viewController
    }
}

extension WineRouter: WineRouterInput {
    func goToLoginScreen() {
        let viewController = LoginBuilder.setupModule()
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func goToSignUpScreen() {
        let viewController = SignUpBuilder.setupModule()
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}

