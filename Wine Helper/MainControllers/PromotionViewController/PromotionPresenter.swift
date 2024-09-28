//
//  PromotionPresenter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/13/24.
//

import UIKit

protocol PromotionViewOutput {
    func specialOfferSeeAllButtonTouchUpInside()
    func newArrivalsSeeAllButtonTouchUpInside()
    func bestSellersSeeAllButtonTouchUpInside()
    func collectionViewCellTouchUpInside(model: WineSelectionInfo)
}

final class PromotionPresenter: PromotionViewOutput {
    
    private unowned let input: PromotionInput
    private let router: PromotionRouterInput
    
    init(input: PromotionInput, router: PromotionRouterInput) {
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
        print(model.id)
        self.router.goToWineViewController(with: model.id, image: model.image)
    }
}

