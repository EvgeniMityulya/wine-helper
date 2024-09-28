//
//  UserDefaultsManager.swift
//  Wine Helper
//
//  Created by Mirogor on 18.04.24.
//

import UIKit

enum UserDefaultsKeys: String {
    case idToken = "idToken"
    case userAccessToken = "userAccessToken"
    case isOnboardingComplete = "isOnboardingComplete"
}

struct UserDefaultsManager {
    static var idToken: String? {
        get { UserDefaults.standard.string(forKey: UserDefaultsKeys.idToken.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.idToken.rawValue) }
    }
    
    static var userAccessToken: String? {
        get { UserDefaults.standard.string(forKey: UserDefaultsKeys.userAccessToken.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.userAccessToken.rawValue) }
    }
    
    static var isOnboardingComplete: Bool? {
        get { UserDefaults.standard.bool(forKey: UserDefaultsKeys.isOnboardingComplete.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isOnboardingComplete.rawValue) }
    }
}
