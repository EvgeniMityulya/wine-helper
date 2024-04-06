//
//  SceneDelegate.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/9/24.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
//        let rootViewController = AuthenticationBuilder.setupModule()
//        self.window?.rootViewController =  UINavigationController(rootViewController: rootViewController)
        self.setupWindow(with: scene)
        self.checkAuthentication()
    }

    public func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.makeKeyAndVisible()
    }
    
    public func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            self.setupRootViewController(with: AuthenticationBuilder.setupModule())
        } else {
            self.setupRootViewController(with: MainTabBarController())
        }
    }
    
    private func setupRootViewController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.25) {
                self?.window?.layer.opacity = 0
            } completion: { [weak self] _ in
                let navController = UINavigationController(rootViewController: viewController)
                self?.window?.rootViewController = navController
                
                UIView.animate(withDuration: 0.25) { [weak self] in
                    self?.window?.layer.opacity = 1
                }
            }
        }
    }
}

