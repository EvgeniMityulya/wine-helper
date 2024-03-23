//
//  MainBuilder.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/23/24.
//

import Foundation

enum MainBuilder {
    static func setupModule() -> MainViewController {
        let viewController = MainViewController()
        let router = MainRouter(viewController: viewController)
        let presenter = MainPresenter(input: viewController, router: router)
        viewController.output = presenter
        return viewController
    }
}

