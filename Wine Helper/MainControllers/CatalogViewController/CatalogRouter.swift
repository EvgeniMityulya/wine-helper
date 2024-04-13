//
//  CatalogRouter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/13/24.
//

import UIKit

protocol CatalogRouterInput {
    func goToLoginScreen()
    func goToSignUpScreen()
}

final class CatalogRouter {
    
    private let viewController: CatalogViewController
    
    init(viewController: CatalogViewController) {
        self.viewController = viewController
    }
}

extension CatalogRouter: CatalogRouterInput {
    func goToLoginScreen() {
        let viewController = LoginBuilder.setupModule()
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func goToSignUpScreen() {
        let viewController = SignUpBuilder.setupModule()
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}

