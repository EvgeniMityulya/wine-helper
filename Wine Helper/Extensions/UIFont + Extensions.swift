//
//  UIFont + Extensions.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/15/24.
//

import UIKit

enum OpenSansFontStyle: String {
    case regular = "OpenSans-Regular"
    case light = "OpenSansRoman-Light"
    case semiBold = "OpenSansRoman-SemiBold"
    case bold = "OpenSansRoman-Bold"
    case extraBold = "OpenSansRoman-ExtraBold"
    
    case condensedBold = "OpenSansRoman-CondensedBold"
    case condensedExtraBold = "OpenSansRoman-CondensedExtraBold"
    case condensedLight = "OpenSansRoman-CondensedLight"
    case condensedRegular = "OpenSansRoman-CondensedRegular"
    case condensedSemiBold = "OpenSansRoman-CondensedSemiBold"
    
}


extension UIFont {
    static func openSans(ofSize size: CGFloat, style: OpenSansFontStyle) -> UIFont {
        return UIFont(name: style.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}
