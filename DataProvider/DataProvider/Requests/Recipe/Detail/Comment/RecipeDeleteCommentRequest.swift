//
//  RecipeDeleteCommentRequest.swift
//  DataProvider
//
//  Created by cihan on 02.06.23.
//


public struct RecipeDeleteCommentRequest: ApiDecodableResponseRequest {
    
    public typealias ResponseType = TextResponse
    
    public var path: String = "recipe/{recipeId}/comment/{commentId}"
    public var method: RequestMethod = .delete
    
    public init(recipeId: Int, commentId: Int) {
        self.path = "recipe/\(recipeId)/comment/\(commentId)"
    }
    
}
