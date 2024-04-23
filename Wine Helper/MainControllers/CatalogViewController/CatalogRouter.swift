//
//  CatalogRouter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/13/24.
//

import UIKit

protocol CatalogRouterInput {
    func goToWineViewController(with id: Int, image: UIImage)
}

final class CatalogRouter {
    
    private let viewController: CatalogViewController
    
    init(viewController: CatalogViewController) {
        self.viewController = viewController
    }
}

extension CatalogRouter: CatalogRouterInput {
    func goToWineViewController(with id: Int, image: UIImage) {
        let viewController = WineBuilder.setupModule(with: id, image: image)
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}

