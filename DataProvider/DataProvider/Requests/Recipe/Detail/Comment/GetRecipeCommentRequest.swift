//
//  GetRecipeCommentRequest.swift
//  DataProvider
//
//  Created by cihan on 01.06.23.
//

public struct GetRecipeCommentsRequest: ApiDecodableResponseRequest {
    
    public typealias ResponseType = MainResponse<[RecipeComment]>
    
    public var path: String = "recipe/{recipeId}/comment"
    public var method: RequestMethod = .get
    public var parameters: [String: Any] = [:]

    public init(recipeId: Int, page: Int? = 1) {
        self.path = "recipe/\(recipeId)/comment"
        self.parameters["page"] = page
    }
    
}
