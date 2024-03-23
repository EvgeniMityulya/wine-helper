//
//  UIView + Extensions.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/17/24.
//

import UIKit

extension UIView {
    func addSubview(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
