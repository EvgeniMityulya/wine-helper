//
//  PromotionRouter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/13/24.
//

import UIKit

protocol PromotionRouterInput {
    func goToWineViewController(with id: Int, image: UIImage)
}

final class PromotionRouter {
    
    private let viewController: PromotionViewController
    
    init(viewController: PromotionViewController) {
        self.viewController = viewController
    }
}

extension PromotionRouter: PromotionRouterInput {
    func goToWineViewController(with id: Int, image: UIImage) {
        let viewController = WineBuilder.setupModule(with: id, image: image)
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}

