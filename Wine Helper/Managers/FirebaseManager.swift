//
//  FirebaseManager.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/23/24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

final class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private init() {}
    
    /// A method to register a the user with email
    /// - Parameters:
    ///   - userRequest: The user information (username, email, password)
    ///   - completion: A complition with 2 values
    ///   - Bool: Is user registered yet
    ///   - Error?: Firebase errors
    public func registerUserEmail(with userRequest: RegisterUserRequest,
                                  completion: @escaping (Bool, Error?) -> Void) {
        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            
            let dataBase = Firestore.firestore()
            
            dataBase.collection("users")
                .document(resultUser.uid)
                .setData([
                    "username" : username,
                    "email" : email,
                    "password": password
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    
                    completion(true, nil)
                }
        }
    }
    
    /// A method to register a the user with Google
    /// - Parameters:
    ///   - withSignInResult: User auth Google data
    ///   - completion: A complition with 2 values
    ///   - Bool: Is user registered yet
    ///   - Error?: Firebase errors
    public func registerUserGoogle(with withSignInResult: GIDSignInResult?,
                                   completion: @escaping (Bool, Error?) -> Void) {
        
        guard let user = withSignInResult?.user, let idToken = user.idToken?.tokenString
        else {
            print("Error user and token")
            return
        }

        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
        
        Auth.auth().signIn(with: credential) { result, error in
            if let error = error {
                print("Error signing in with Google: \(error.localizedDescription)")
                completion(false, error)
                return
            }
            
            completion(true, nil)
        }
    }
    
    /// A method to register a the user with Apple
    /// - Parameters:
    ///   - withSignInResult: User auth Google data
    ///   - completion: A complition with 2 values
    ///   - Bool: Is user registered yet
    ///   - Error?: Firebase errors
    public func registerUserApple(with firebaseCredential: AuthCredential,
                                   completion: @escaping (Bool, Error?) -> Void) {
        
        
        Auth.auth().signIn(with: firebaseCredential) { result, error in
            if let error = error {
                print("Error signing in with Google: \(error.localizedDescription)")
                completion(false, error)
                return
            }
            
            completion(true, nil)
        }
    }
    
    public func signInEmail(with userRequest: LoginUserRequest,
                            completion: @escaping (Error?) -> Void) {
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().signIn(
            withEmail: email,
            password: password
        ) { result, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }
    
    public func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
}

extension FirebaseManager: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        self
    }
}
