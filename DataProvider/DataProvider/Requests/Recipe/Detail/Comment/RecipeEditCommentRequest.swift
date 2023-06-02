//
//  RecipeEditCommentRequest.swift
//  DataProvider
//
//  Created by cihan on 02.06.23.
//

public struct RecipeEditCommentRequest: ApiDecodableResponseRequest {
    
    public typealias ResponseType = TextResponse
    
    public var path: String = "recipe/{recipeId}/comment/{commentId}"
    public var method: RequestMethod = .put
    public var parameters: [String: Any] = [:]

    public init(recipeId: Int, commentId: Int, commentText: String) {
        self.path = "recipe/\(recipeId)/comment/\(commentId)"
        self.parameters["text"] = commentText
    }

}
