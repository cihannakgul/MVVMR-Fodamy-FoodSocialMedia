//
//  PageControl.swift
//  UIComponents
//
//  Created by cihan on 24.03.23.
//

import UIKit
 

public class PageControl: UIPageControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    // swiftlint:disable fatal_error unavailable_function
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // swiftlint:enable fatal_error unavailable_function
    
    private func configureContents() {
        tintColor = .appRed
        pageIndicatorTintColor = UIColor.appRed.withAlphaComponent(0.3)
        currentPageIndicatorTintColor = .appRed
    }
    
}
