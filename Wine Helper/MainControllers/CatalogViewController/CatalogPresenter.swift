//
//  CatalogPresenter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/24/24.
//

import UIKit

protocol CatalogViewOutput {

}

final class CatalogPresenter: CatalogViewOutput {
    
    private unowned let input: CatalogInput
    private let router: CatalogRouterInput
    
    init(input: CatalogInput, router: CatalogRouterInput) {
        self.input = input
        self.router = router
    }
    
}
