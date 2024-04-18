//
//  UserDefaultsManager.swift
//  Wine Helper
//
//  Created by Mirogor on 18.04.24.
//

import UIKit

struct UserDefaultsManager {
    static var idToken: String? {
        get { UserDefaults.standard.string(forKey: "idToken") }
        set { UserDefaults.standard.set(newValue, forKey: "idToken") }
    }
    
    static var userAccessToken: String? {
        get { UserDefaults.standard.string(forKey: "userAccessToken") }
        set { UserDefaults.standard.set(newValue, forKey: "userAccessToken") }
    }
}
