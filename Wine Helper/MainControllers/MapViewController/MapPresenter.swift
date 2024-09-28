//
//  MapPresenter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/13/24.
//

import UIKit

protocol MapViewOutput {
    
}

final class MapPresenter: MapViewOutput {
    
    private unowned let input: MapViewInput
    private let router: MapRouterInput
    
    init(input: MapViewInput, router: MapRouterInput) {
        self.input = input
        self.router = router
    }
    
}
