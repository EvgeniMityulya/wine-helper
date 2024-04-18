//
//  SignUpBuilder.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/17/24.
//

import Foundation

enum SignUpBuilder {
    static func setupModule() -> SignUpViewController {
        let viewController = SignUpViewController()
        let router = SignUpRouter(viewController: viewController)
        let presenter = SignUpPresenter(input: viewController, router: router, parent: viewController)
        viewController.output = presenter
        return viewController
    }
}
