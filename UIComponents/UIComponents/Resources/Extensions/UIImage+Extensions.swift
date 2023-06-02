//
//  UIImage+Extensions.swift
//  UIComponents
//
//  Created by cihan on 27.03.23.
//

import UIKit



public extension UIImage {
    
    func resize(to size: CGSize, for contentMode: UIView.ContentMode? = nil) -> UIImage {
        switch contentMode {
        case .scaleAspectFit:
            return kf.resize(to: size, for: .aspectFit)
        case .scaleToFill:
            return kf.resize(to: size, for: .aspectFill)
        default:
            return kf.resize(to: size)
        }
    }
    
}
