//
//  FilterRouter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/24/24.
//

import UIKit

protocol FilterRouterInput {
    func goToWineViewController(with id: Int, image: UIImage)
}

final class FilterRouter {
    
    private let viewController: FilterViewController
    
    init(viewController: FilterViewController) {
        self.viewController = viewController
    }
}

extension FilterRouter: FilterRouterInput {
}
