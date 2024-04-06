//
//  FirebaseManager.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/23/24.
//

import Foundation
import Firebase

final class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private init() {}
    
    /// A method to register a the iser
    /// - Parameters:
    ///   - userRequest: The user information (username, email, password)
    ///   - completion: A complition with 2 values
    ///   - Bool: Is user registered yet
    ///   - Error?: Firebase errors
    public func registerUser(with userRequest: RegisterUserRequest,
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
    
    public func signIn(with userRequest: LoginUserRequest,
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
