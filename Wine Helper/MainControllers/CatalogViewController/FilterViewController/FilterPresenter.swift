//
//  FilterPresenter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/24/24.
//
import UIKit

protocol FilterViewOutput {

}

final class FilterPresenter: FilterViewOutput {
    
    private unowned let input: FilterInput
    private let router: FilterRouterInput
    
    init(input: FilterInput, router: FilterRouterInput) {
        self.input = input
        self.router = router
    }
    
}

