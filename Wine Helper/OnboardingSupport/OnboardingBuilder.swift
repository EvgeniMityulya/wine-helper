//
//  OnboardingBuilder.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/25/24.
//

import Foundation

enum OnboardingBuilder {
    static func setupModule() -> OnboardingViewController {
        let viewController = OnboardingViewController()
        let router = OnboardingRouter(viewController: viewController)
        let presenter = OnboardingPresenter(input: viewController, router: router)
        viewController.output = presenter
        return viewController
    }
}
