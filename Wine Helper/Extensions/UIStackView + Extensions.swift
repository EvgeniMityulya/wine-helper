//
//  UIStackView + Extensions.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/21/24.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
