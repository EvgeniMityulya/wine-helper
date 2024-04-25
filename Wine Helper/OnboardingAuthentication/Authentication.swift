//
//  Authentication.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/24/24.
//

import UIKit

protocol Authentication {
    func checkAuth()
}

extension Authentication where Self: UIViewController {
    func checkAuth() {
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkUserStatus()
        }
    }
}
