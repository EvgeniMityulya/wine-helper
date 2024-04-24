//
//  PromotionBuilder.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/13/24.
//

import Foundation

enum PromotionBuilder {
    static func setupModule() -> PromotionViewController {
        let viewController = PromotionViewController()
        let router = PromotionRouter(viewController: viewController)
        let presenter = PromotionPresenter(input: viewController, router: router)
        viewController.output = presenter
        return viewController
    }
}
