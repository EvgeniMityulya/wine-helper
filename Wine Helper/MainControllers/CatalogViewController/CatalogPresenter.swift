//
//  CatalogPresenter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/13/24.
//

import UIKit

protocol CatalogViewOutput {
    func specialOfferSeeAllButtonTouchUpInside()
    func newArrivalsSeeAllButtonTouchUpInside()
    func bestSellersSeeAllButtonTouchUpInside()
    func collectionViewCellTouchUpInside(model: WineSelectionInfo)
}

final class CatalogPresenter: CatalogViewOutput {
    
    private unowned let input: CatalogViewInput
    private let router: CatalogRouterInput
    
    init(input: CatalogViewInput, router: CatalogRouterInput) {
        self.input = input
        self.router = router
    }
    func specialOfferSeeAllButtonTouchUpInside() {
        print("specialOfferSeeAllButtonTouchUpInside")
    }
    
    func newArrivalsSeeAllButtonTouchUpInside() {
        print("newArrivalsSeeAllButtonTouchUpInside")
    }
    
    func bestSellersSeeAllButtonTouchUpInside() {
        print("newArrivalsSeeAllButtonTouchUpInside")
    }
    
    func collectionViewCellTouchUpInside(model: WineSelectionInfo) {
        self.router.goToWineViewController(with: model.id, image: model.image)
    }
}

