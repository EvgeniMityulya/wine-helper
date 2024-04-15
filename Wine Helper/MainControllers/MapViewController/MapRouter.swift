//
//  MapRouter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/13/24.
//

import UIKit

protocol MapRouterInput {
    func goToLoginScreen()
    func goToSignUpScreen()
}

final class MapRouter {
    
    private let viewController: MapViewController
    
    init(viewController: MapViewController) {
        self.viewController = viewController
    }
}

extension MapRouter: MapRouterInput {
    func goToLoginScreen() {
        let viewController = LoginBuilder.setupModule()
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func goToSignUpScreen() {
        let viewController = SignUpBuilder.setupModule()
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
