//
//  InsetTextField.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/10/24.
//

import UIKit

private class InsetTextField: UITextField {
    var insets: UIEdgeInsets
    
    init(insets: UIEdgeInsets) {
        self.insets = insets
        super.init(frame: .zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("not intended for use from a NIB")
    }
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: bounds.inset(by: insets))
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: bounds.inset(by: insets))
    }
    
}

extension UITextField {
    
    class func textFieldWithInsets(insets: UIEdgeInsets) -> UITextField {
        return InsetTextField(insets: insets)
    }
    
    func setUnderLine() {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        lineView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lineView)
        
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            lineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}
