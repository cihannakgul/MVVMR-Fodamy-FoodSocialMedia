//
//  GetRecipeDetailRequest.swift
//  DataProvider
//
//  Created by cihan on 01.06.23.
//

import Foundation

public struct GetRecipeDetailRequest: ApiDecodableResponseRequest {
    
    public typealias ResponseType = RecipeDetail
    
    public var path: String = "recipe/{recipeId}"
    public var method: RequestMethod = .get
    
    public init(recipeId: Int) {
        self.path = "recipe/\(recipeId)"
    }
}
