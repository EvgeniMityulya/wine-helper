//
//  WinePresenter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/13/24.
//

import UIKit

protocol WineViewOutput {
    func specialOfferSeeAllButtonTouchUpInside()
    func newArrivalsSeeAllButtonTouchUpInside()
}

final class WinePresenter: WineViewOutput {
    
    private unowned let input: WineViewInput
    private let router: WineRouterInput
    
    init(input: WineViewInput, router: WineRouterInput) {
        self.input = input
        self.router = router
    }
    func specialOfferSeeAllButtonTouchUpInside() {
        print("specialOfferSeeAllButtonTouchUpInside")
    }
    
    func newArrivalsSeeAllButtonTouchUpInside() {
        print("newArrivalsSeeAllButtonTouchUpInside")
    }
}

