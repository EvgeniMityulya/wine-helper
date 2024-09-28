//
//  CatalogPresenter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/24/24.
//

import UIKit

protocol CatalogViewOutput {
    func collectionViewCellTouchUpInside(model: WineSelectionInfo)
}

final class CatalogPresenter: CatalogViewOutput {
    
    private unowned let input: CatalogInput
    private let router: CatalogRouterInput
    
    init(input: CatalogInput, router: CatalogRouterInput) {
        self.input = input
        self.router = router
    }
    
    func collectionViewCellTouchUpInside(model: WineSelectionInfo) {
        print(model.id)
        self.router.goToWineViewController(with: model.id, image: model.image)
    }
}
