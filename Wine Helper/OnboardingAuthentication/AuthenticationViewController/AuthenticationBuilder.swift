//
//  AuthenticationBuilder.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/15/24.
//

import Foundation

enum AuthenticationBuilder {
    static func setupModule() -> AuthenticationViewController {
        let viewController = AuthenticationViewController()
        let router = AuthenticationRouter(viewController: viewController)
        let presenter = AuthenticationPresenter(input: viewController, router: router)
        viewController.output = presenter
        return viewController
    }
}
