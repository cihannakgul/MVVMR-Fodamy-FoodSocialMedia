//
//  RecipePostCommentRequest.swift
//  DataProvider
//
//  Created by cihan on 02.06.23.
//

public struct RecipePostCommentRequest: ApiDecodableResponseRequest {
    
    public typealias ResponseType = RecipeComment

    public var path: String = "recipe/{recipeId}/comment"
    public var method: RequestMethod = .post
    public var parameters: [String: Any] = [:]

    public init(recipeId: Int, commentText: String) {
        self.path = "recipe/\(recipeId)/comment"
        self.parameters["text"] = commentText
    }
    
}
