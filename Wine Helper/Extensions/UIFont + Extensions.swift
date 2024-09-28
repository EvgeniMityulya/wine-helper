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

enum PlayfairFontStyle: String {
    case regular = "PlayfairDisplay-Regular"
    case medium = "PlayfairDisplayRoman-Medium"
    case semiBold = "PlayfairDisplayRoman-SemiBold"
    case bold = "PlayfairDisplayRoman-Bold"
    case extraBold = "PlayfairDisplayRoman-ExtraBold"
    case black = "PlayfairDisplayRoman-Black"
}

enum RobotoFlexFontStyle: String {
    case regular = "RobotoFlex-Regular"
    case italic = "RobotoFlex-Regular_Italic"
    case thin = "RobotoFlex-Regular_Thin"
    case thinItalic = "RobotoFlex-Regular_Thin-Italic"
    case extraLight = "RobotoFlex-Regular_ExtraLight"
    case extraLightItalic = "RobotoFlex-Regular_ExtraLight-Italic"
    case light = "RobotoFlex-Regular_Light"
    case lightItalic = "RobotoFlex-Regular_Light-Italic"
    case medium = "RobotoFlex-Regular_Medium"
    case mediumItalic = "RobotoFlex-Regular_Medium-Italic"
    case semiBold = "RobotoFlex-Regular_SemiBold"
    case semiBoldItalic = "RobotoFlex-Regular_SemiBold-Italic"
    case bold = "RobotoFlex-Regular_Bold"
    case boldItalic = "RobotoFlex-Regular_Bold-Italic"
    case extraBold = "RobotoFlex-Regular_ExtraBold"
    case extraBoldItalic = "RobotoFlex-Regular_ExtraBold-Italic"
    case black = "RobotoFlex-Regular_Black"
    case blackItalic = "RobotoFlex-Regular_Black-Italic"
    case extraBlack = "RobotoFlex-Regular_ExtraBlack"
    case extraBlackItalic = "RobotoFlex-Regular_ExtraBlack-Italic"
}


extension UIFont {
    static func openSans(ofSize size: CGFloat, style: OpenSansFontStyle) -> UIFont {
        return UIFont(name: style.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
    
    static func playfair(ofSize size: CGFloat, style: PlayfairFontStyle) -> UIFont {
        return UIFont(name: style.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
    
    static func robotoFlex(ofSize size: CGFloat, style: RobotoFlexFontStyle) -> UIFont {
        return UIFont(name: style.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}
