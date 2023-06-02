//
//  RecipeCell.swift
//  UIComponents
//
//  Created by cihan on 07.04.23.
//

import Foundation
import UIKit
import MobilliumBuilders

public class RecipeCell: UICollectionViewCell, ReusableView {
    
    public static var identifier: String =  "RecipeCell"

    private let userView = UserInfoView(userViewType: .withoutFollowButton)
    
    private let separatorLine = UIViewBuilder()
            .backgroundColor(.appZircon)
            .build()
    
    private let recipeTitlesContainerView = UIView()
    
    private let recipeTitleStackView = UIStackViewBuilder()
            .axis(.vertical)
            .distribution(.fillEqually)
            .build()
    
    private let recipeTitleLabel = UILabelBuilder()
            .font(.font(.nunitoBold, size: .xLarge))
            .textColor(.appCinder)
            .build()
    
    private let recipeCategoryLabel = UILabelBuilder()
            .font(.font(.nunitoSemiBold, size: .xLarge))
            .textColor(.appRaven)
            .build()
    
    private let recipeImageView = UIImageViewBuilder()
            .cornerRadius(4)
            .clipsToBounds(true)
            .contentMode(.scaleAspectFill)
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
    
    private let recipeCommentAndLikeContainerView = UIView()
    
    private let recipeCommentAndLikeCountLabel = UILabelBuilder()
            .font(.font(.nunitoSemiBold, size: .medium))
            .textColor(.appRaven)
            .build()
    
    weak var viewModel: RecipeCellProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubViews()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
            self.userView.username = nil
            self.userView.userImageUrl = nil
            self.userView.recipeAndFollowerCountText = nil
            self.recipeTitleLabel.text = nil
            self.recipeCategoryLabel.text = nil
            self.recipeImageView.image = nil
            self.recipeCommentAndLikeCountLabel.text = nil
        }
    
    public func set(viewModel: RecipeCellProtocol) {
        self.viewModel = viewModel
        userView.username = viewModel.username
        userView.recipeAndFollowerCountText = viewModel.userRecipeAndFollowerCountText
        userView.userImageUrl = viewModel.userImageUrl
        recipeTitleLabel.text = viewModel.recipeTitle
        recipeCategoryLabel.text = viewModel.categoryName
        recipeCommentAndLikeCountLabel.text = viewModel.recipeCommnetAndLikeCountText
        recipeImageView.setImage(viewModel.recipeImageUrl)
        editoryPickImageView.isHidden = !viewModel.isEditorChoice
    }
}
extension RecipeCell {
    
    private func addSubViews() {
        backgroundColor = .white
        addUserView()
        addSeperator()
        addRecipeTitlesContainerView()
        addRecipteTitleStackView()
        addRecipeImageAndEditoryPickImageView()
        addEditoryPickImage()
        addRecipeCommentAndLikeContainerView()
        addRecipeCommentAndLikeCountLabel()
    }

    private func addUserView() {
        contentView.addSubview(userView)
        userView.edgesToSuperview(excluding: .bottom)
        userView.height(70)
    }

    private func addSeperator() {
        contentView.addSubview(separatorLine)
        separatorLine.topToBottom(of: userView)
        separatorLine.edgesToSuperview(excluding: [.bottom, .top])
        separatorLine.height(1)
    }

    private func addRecipeTitlesContainerView() {
        contentView.addSubview(recipeTitlesContainerView)
        recipeTitlesContainerView.topToBottom(of: separatorLine)
        recipeTitlesContainerView.leadingToSuperview().constant = 15
        recipeTitlesContainerView.trailingToSuperview().constant = -15
        recipeTitlesContainerView.height(61)
    }
    
    private func addRecipteTitleStackView() {
        recipeTitlesContainerView.addSubview(recipeTitleStackView)
        recipeTitleStackView.edgesToSuperview(excluding: [.top, .bottom])
        recipeTitleStackView.centerYToSuperview()
        recipeTitleStackView.addArrangedSubview(recipeTitleLabel)
        recipeTitleStackView.addArrangedSubview(recipeCategoryLabel)
    }

    private func addRecipeImageAndEditoryPickImageView() {
        contentView.addSubview(recipeImageView)
        recipeImageView.topToBottom(of: recipeTitlesContainerView)
        recipeImageView.leadingToSuperview().constant = 15
        recipeImageView.trailingToSuperview().constant = -15
        recipeImageView.aspectRatio(1 / 1)
    }
    
    private func addEditoryPickImage() {
        contentView.addSubview(editoryPickImageView)
        editoryPickImageView.top(to: recipeImageView).constant = 15
        editoryPickImageView.trailing(to: recipeImageView).constant = -15
        editoryPickImageView.size(.init(width: 40, height: 40))
    }

    private func addRecipeCommentAndLikeContainerView() {
        contentView.addSubview(recipeCommentAndLikeContainerView)
        recipeCommentAndLikeContainerView.topToBottom(of: recipeImageView)
        recipeCommentAndLikeContainerView.leadingToSuperview().constant = 15
        recipeCommentAndLikeContainerView.trailingToSuperview().constant = -15
        recipeCommentAndLikeContainerView.height(43)
    }
    
    private func addRecipeCommentAndLikeCountLabel() {
        recipeCommentAndLikeContainerView.addSubview(recipeCommentAndLikeCountLabel)
        recipeCommentAndLikeCountLabel.centerYToSuperview()
        recipeCommentAndLikeCountLabel.edgesToSuperview(excluding: [.top, .bottom])
    }
}
