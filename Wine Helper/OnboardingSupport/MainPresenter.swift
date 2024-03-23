//
//  MainPresenter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/23/24.
//

import UIKit

protocol MainViewOutput {
//    func loginButtonTouchDown(_ sender: UIButton)
//    func loginButtonTouchUpInside(_ sender: UIButton)
//    func loginButtonTouchUpOutside(_ sender: UIButton)
//    
//    func signUpButtonTouchDown(_ sender: UIButton)
//    func signUpButtonTouchUpInside(_ sender: UIButton)
//    func signUpButtonTouchUpOutside(_ sender: UIButton)
}

final class MainPresenter: MainViewOutput {
    private unowned let input: MainViewInput
    private let router: MainRouterInput
    
    init(input: MainViewInput, router: MainRouterInput) {
        self.input = input
        self.router = router
    }
    

}
