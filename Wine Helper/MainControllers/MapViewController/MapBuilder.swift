//
//  MapBuilder.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/13/24.
//

import Foundation

enum MapBuilder {
    static func setupModule() -> MapViewController {
        let viewController = MapViewController()
        let router = MapRouter(viewController: viewController)
        let presenter = MapPresenter(input: viewController, router: router)
        viewController.output = presenter
        return viewController
    }
}

