//
//  RecipeDetailHeaderCellModel.swift
//  UIComponents
//
//  Created by cihan on 31.05.23.
//

import Foundation

public protocol RecipeHeaderCellDataSource {
    var imageUrl: String { get }
    var isEditorChoice: Bool { get }
}

public protocol RecipeHeaderCellEventSource {
    
}

public protocol RecipeHeaderCellProtocol: RecipeHeaderCellDataSource, RecipeHeaderCellEventSource {
    
}

public final class RecipeHeaderCellModel: RecipeHeaderCellProtocol {
    public var imageUrl: String
    public var isEditorChoice: Bool
    
    public init(imageUrl: String, isEditorChoice: Bool) {
        self.imageUrl = imageUrl
        self.isEditorChoice = isEditorChoice
    }
}
