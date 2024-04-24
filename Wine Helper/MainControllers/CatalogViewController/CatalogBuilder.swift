//
//  CatalogBuilder.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/24/24.
//

import Foundation

enum CatalogBuilder {
    static func setupModule() -> CatalogViewController {
        let viewController = CatalogViewController()
        let router = CatalogRouter(viewController: viewController)
        let presenter = CatalogPresenter(input: viewController, router: router)
        viewController.output = presenter
        return viewController
    }
}

