//
//  OnboardingPresenter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/25/24.
//

import UIKit

protocol OnboardingViewOutput {
    func nextButtonTouchDown(_ sender: UIButton)
    func nextButtonTouchUpInside(_ sender: UIButton)
    func nextButtonTouchUpOutside(_ sender: UIButton)
    func slideCollectionViewInput(_ scrollView: UIScrollView)
}

final class OnboardingPresenter: OnboardingViewOutput {
    
    private unowned let input: OnboardingInput
    private let router: OnboardingRouterInput
    
    init(input: OnboardingInput, router: OnboardingRouterInput) {
        self.input = input
        self.router = router
    }
    
    func nextButtonTouchDown(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 0.8)
    }
    
    func nextButtonTouchUpInside(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 1)
        if input.isLastSlide() {
            UserDefaultsManager.isOnboardingComplete = true
            router.navigateToMainScreen()
        } else {
            input.nextCollectionViewItem()
        }
    }
    
    func nextButtonTouchUpOutside(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 1)
    }
    
    func slideCollectionViewInput(_ scrollView: UIScrollView) {
        input.slideCollectionViewItem(scrollView)
    }
}


