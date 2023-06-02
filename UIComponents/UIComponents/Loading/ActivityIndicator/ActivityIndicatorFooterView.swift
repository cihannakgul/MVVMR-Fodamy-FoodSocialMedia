//
//  ActivityIndicatorFooterView.swift
//  UIComponents
//
//  Created by cihan on 08.05.23.
//
import UIKit

public class ActivityIndicatorFooterView: UICollectionReusableView, ReusableView {
    public static var identifier: String = "Activity"
    
    
    public let activityIndicator = ActivityIndicatorView(frame: .infinite)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }

    private func setupConstraints() {
        addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
    }
}
