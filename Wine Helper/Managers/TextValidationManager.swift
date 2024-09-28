//
//  TextValidationManager.swift
//  Wine Helper
//
//  Created by Mirogor on 18.04.24.
//

import UIKit

final class TextValidationManager {
    
    private init() {}
    
    static let shared = TextValidationManager()
    
    func isValidUsername(_ username: String) -> Bool {
        username.count >= 4
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        password.count >= 8
    }
    
    func showAlert(vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        vc.present(alert, animated: true, completion: nil)
    }
}
