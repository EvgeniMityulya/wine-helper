//
//  LoginBuilder.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/15/24.
//

import Foundation

enum LoginBuilder {
    static func setupModule() -> LoginViewController {
        let viewController = LoginViewController()
        let router = LoginRouter(viewController: viewController)
        let presenter = LoginPresenter(parent: viewController, input: viewController, router: router)
        viewController.output = presenter
        return viewController
    }
}
