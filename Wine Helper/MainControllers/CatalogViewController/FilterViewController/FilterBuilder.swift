//
//  FilterBuilder.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/24/24.
//

import Foundation

enum FilterBuilder {
    static func setupModule() -> FilterViewController {
        let viewController = FilterViewController()
        let router = FilterRouter(viewController: viewController)
        let presenter = FilterPresenter(input: viewController, router: router)
        viewController.output = presenter
        return viewController
    }
}
