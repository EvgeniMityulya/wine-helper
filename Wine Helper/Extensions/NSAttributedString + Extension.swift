//
//  NSAttributedString + Extension.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/21/24.
//

import Foundation

extension NSAttributedString {
    static func attributedString(withText text: String, spacing: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
}
