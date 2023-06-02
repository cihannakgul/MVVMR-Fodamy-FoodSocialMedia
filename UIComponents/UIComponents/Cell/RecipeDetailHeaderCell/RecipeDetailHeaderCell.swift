//
//  RecipeDetailHeaderCell.swift
//  UIComponents
//
//  Created by cihan on 31.05.23.
//

import Foundation
import UIKit
import MobilliumBuilders

public class RecipeHeaderCell: UICollectionViewCell, ReusableView {
    public static var identifier: String = "RecipeDetailHeaderCell"
    
    
    private let headerImageView = UIImageViewBuilder()
        .backgroundColor(.clear)
        .contentMode(.scaleAspectFill)
        .clipsToBounds(true)
        .build()
    
    private let editoryPickImageView = UIImageViewBuilder()
        .contentMode(.center)
        .image(UIImage.imgEditorsPick.resize(to: .init(width: 20, height: 24), for: .scaleAspectFit))
        .cornerRadius(20)
        .shadowColor(UIColor.appCinder.cgColor)
        .shadowOpacity(0.40)
        .shadowOffset(.zero)
        .shadowRadius(4)
        .backgroundColor(.appWhite)
        .build()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubViews()
    }
}

// MARK: - UILayout
extension RecipeHeaderCell {
    
    private func addSubViews() {
        contentView.addSubview(headerImageView)
        headerImageView.edgesToSuperview()
        
        contentView.addSubview(editoryPickImageView)
        editoryPickImageView.top(to: headerImageView).constant = 15
        editoryPickImageView.trailing(to: headerImageView).constant = -15
        editoryPickImageView.size(.init(width: 40, height: 40))
    }
}

// MARK: - Set ViewModel
public extension RecipeHeaderCell {
    func set(with viewModel: RecipeHeaderCellProtocol) {
        headerImageView.setImage(viewModel.imageUrl)
        editoryPickImageView.isHidden = !viewModel.isEditorChoice
    }
}
