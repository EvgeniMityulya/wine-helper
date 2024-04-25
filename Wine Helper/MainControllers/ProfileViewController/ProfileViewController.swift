//
//  ProfileViewController.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/23/24.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

final class ProfileViewController: UIViewController {
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log out", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        button.backgroundColor = UIColor.CustomColors.burgundy
        button.addTarget(self, action: #selector(logOutUpButtonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(logOutButtonTouchUpInside), for: .touchUpInside)
        button.addTarget(self, action: #selector(logOutButtonTouchUpOutside), for: .touchUpOutside)
        return button
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        print(Auth.auth().currentUser?.email ?? "0", Auth.auth().currentUser?.displayName ?? "1")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        navigationItem.title = "Profile"
        self.setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(
            self.logOutButton
        )
        
        NSLayoutConstraint.activate([
            self.logOutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logOutButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
    private func setupNavigationBar() {
//        let appereance = UINavigationBarAppearance
    }
}

private extension ProfileViewController {
    @objc private func logOutUpButtonTouchDown() {
    }
    
    @objc private func logOutButtonTouchUpInside() {
        FirebaseManager.shared.signOut { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkUserStatus()
            }
        }
        print("Sign out success")
    }
    
    @objc private func logOutButtonTouchUpOutside() {

    }
}
