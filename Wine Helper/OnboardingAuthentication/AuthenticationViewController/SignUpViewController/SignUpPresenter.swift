//
//  SignUpPresenter.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/17/24.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth
import FirebaseCore
import AuthenticationServices
import CryptoKit

protocol SignUpViewOutput {
    func eyeButtonTapped()
    func signUpButtonTouchDown(_ sender: UIButton)
    func signUpButtonTouchUpInside(_ sender: UIButton)
    func signUpButtonTouchUpOutside(_ sender: UIButton)
    
    func signUpGoogleButtonTouchUpInside(_ sender: UIButton)
    func signUpAppleButtonTouchUpInside(_ sender: UIButton)
}

final class SignUpPresenter: SignUpViewOutput {
    
    private unowned let input: SignUpViewInput
    private let router: SignUpRouterInput
    private let parentViewController: SignUpViewController
    
    init(input: SignUpViewInput, router: SignUpRouterInput, parent: SignUpViewController) {
        self.input = input
        self.router = router
        self.parentViewController = parent
    }
    
    func eyeButtonTapped() {
        input.changeEyeButtonImage()
    }
    
    func signUpButtonTouchDown(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 0.8)
    }
    
    func signUpButtonTouchUpInside(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 1)
        
        guard let userRequest = input.getRegisterUserRequest() else {
            print("Пожалуйста, заполните все поля.")
            return
        }
        
        FirebaseManager.shared.registerUserEmail(with: userRequest) { isRegistered, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.input.checkAuth()
            print("Registered success")
        }

    }
    
    func signUpGoogleButtonTouchUpInside(_ sender: UIButton) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        
        GIDSignIn.sharedInstance.signIn(withPresenting: self.parentViewController) { result, error in
            if let error = error {
                print("Ошибка аутентификации через Google: \(error.localizedDescription)")
                return
            }
            
            FirebaseManager.shared.registerUserGoogle(with: result) { isRegistered, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                self.input.checkAuth()
                print("Registered success")
            }
        }
    }
    
    func signUpAppleButtonTouchUpInside(_ sender: UIButton) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        self.parentViewController.currentNonce = randomNonceString()
        request.nonce = sha256(self.parentViewController.currentNonce!)

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self.parentViewController
        authorizationController.presentationContextProvider = self.parentViewController
        authorizationController.performRequests()
    }
    
    func signUpButtonTouchUpOutside(_ sender: UIButton) {
        input.changeButtonBackgroundColorWithAlpha(sender, color: UIColor.CustomColors.burgundy, alpha: 1)
    }
}

extension SignUpPresenter {
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}

extension SignUpViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        ASPresentationAnchor.init()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            // Save authorised user ID for future reference
            UserDefaults.standard.set(appleIDCredential.user, forKey: "appleAuthorizedUserIdKey")
            
            // Retrieve the secure nonce generated during Apple sign in
            guard let nonce = self.currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }

            // Retrieve Apple identity token
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Failed to fetch identity token")
                return
            }

            // Convert Apple identity token to string
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Failed to decode identity token")
                return
            }

            // Initialize a Firebase credential using secure nonce and Apple identity token
            let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com",
                                                              idToken: idTokenString,
                                                              rawNonce: nonce)
                
            FirebaseManager.shared.registerUserApple(with: firebaseCredential) { _, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
                print("Registered success")
            }
            
        }
    }
}
