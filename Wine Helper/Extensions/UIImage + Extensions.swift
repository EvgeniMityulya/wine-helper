//
//  UIImage + Extensions.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/10/24.
//

import UIKit

extension UIImage {
    public static func pixel(ofColor color: UIColor) -> UIImage {
        let pixel = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContext(pixel.size)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        
        context.setFillColor(color.cgColor)
        context.fill(pixel)
        
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
    
    func scaledToFit(size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    func resized(to newSize: CGSize) -> UIImage {
           let horizontalRatio = newSize.width / size.width
           let verticalRatio = newSize.height / size.height
           let ratio = min(horizontalRatio, verticalRatio)
           let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
           return UIGraphicsImageRenderer(size: newSize).image { _ in
               self.draw(in: CGRect(origin: .zero, size: newSize))
           }
       }
}

