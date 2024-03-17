//
//  UIColor + Extensions.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/14/24.
//

import UIKit

extension UIColor {
    struct CustomColors {
        static var burgundy: UIColor {
            return UIColor(named: "BurgundyColor") ?? .red
        }
        
        static var background: UIColor {
            return UIColor(named: "BackgroundColor") ?? .white
        }
        
        static var text: UIColor {
            return UIColor(named: "TextColor") ?? .white
        }
    }
}
