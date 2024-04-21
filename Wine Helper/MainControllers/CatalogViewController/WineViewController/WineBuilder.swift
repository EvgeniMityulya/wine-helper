//
//  WineBuilder.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/13/24.
//

import Foundation

enum WineBuilder {
    static func setupModule() -> WineViewController {
        let viewController = WineViewController()
        let router = WineRouter(viewController: viewController)
        let presenter = WinePresenter(input: viewController, router: router)
        viewController.output = presenter
        return viewController
    }
}
