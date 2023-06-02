//
//  ActivityIndicatorView.swift
//  UIComponents
//
//  Created by cihan on 08.05.23.
//


import UIKit

public class ActivityIndicatorView: UIActivityIndicatorView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        style = .gray
        tintColor = .appCinder
        hidesWhenStopped = true
    }
    
}
