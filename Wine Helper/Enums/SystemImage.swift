//
//  SystemImage.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/14/24.
//

import UIKit

enum SystemImage: String {
    case envelope = "envelope" // mail
    case lock = "lock"
    case applelogo = "applelogo"
    case eyeSlash = "eye.slash"
    case eye = "eye"
    case person = "person"
    case location = "location"
    case wineglass = "wineglass"
    
    var image: UIImage? {
        return UIImage(systemName: self.rawValue)
    }
}
