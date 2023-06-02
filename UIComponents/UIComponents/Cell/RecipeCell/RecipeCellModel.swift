//
//  RecipeCellModel.swift
//  UIComponents
//
//  Created by cihan on 07.04.23.
//

import Foundation
import Utilities
import DataProvider
public protocol RecipeCellDataSource: AnyObject {
    var recipeId: Int { get }
    var userId: Int { get }
    var userImageUrl: String? { get }
    var username: String? { get }
    var userRecipeAndFollowerCountText: String? { get }
    var recipeTitle: String? { get }
    var categoryName: String? { get }
    var recipeImageUrl: String? { get }
    var recipeCommnetAndLikeCountText: String? { get }
    var isEditorChoice: Bool { get }
}

public protocol RecipeCellEventSource: AnyObject {
    var followButtonTapped: VoidClosure? { get set }
}

public protocol RecipeCellProtocol: RecipeCellDataSource, RecipeCellEventSource {
    
}

public class RecipeCellModel: RecipeCellProtocol {
    public var recipeId: Int
    public var userId: Int
    public var userImageUrl: String?
    public var username: String?
    public var userRecipeAndFollowerCountText: String?
    public var recipeTitle: String?
    public var categoryName: String?
    public var recipeImageUrl: String?
    public var recipeCommnetAndLikeCountText: String?
    public var isEditorChoice = false
    public var followButtonTapped: VoidClosure?

    public init(recipeId: Int,
                userId: Int,
                userImageUrl: String?,
                username: String?,
                userRecipeAndFollowerCountText: String?,
                recipeTitle: String?,
                categoryName: String?,
                recipeImageUrl: String?,
                recipeCommnetAndLikeCountText: String?,
                isEditorChoice: Bool) {
            self.recipeId = recipeId
            self.userId = userId
            self.userImageUrl = userImageUrl
            self.username = username
            self.userRecipeAndFollowerCountText = userRecipeAndFollowerCountText
            self.recipeTitle = recipeTitle
            self.categoryName = categoryName
            self.recipeImageUrl = recipeImageUrl
            self.recipeCommnetAndLikeCountText = recipeCommnetAndLikeCountText
            self.isEditorChoice = isEditorChoice
        }
}
extension RecipeCellModel {
    
    public convenience init(recipe: Recipe) {
        self.init(recipeId: recipe.id,
                  userId: recipe.user.id,
                  userImageUrl: recipe.user.image?.url,
                  username: recipe.user.username,
                  userRecipeAndFollowerCountText: "\(recipe.user.recipeCount) Tarif \(recipe.user.followingCount) Takipçi",
                  recipeTitle: recipe.title,
                  categoryName: recipe.category.name,
                  recipeImageUrl: recipe.images.first?.url,
                  recipeCommnetAndLikeCountText: "\(recipe.commentCount) Yorum \(recipe.likeCount) Beğeni",
                  isEditorChoice: recipe.isEditorChoice)
    }
}
