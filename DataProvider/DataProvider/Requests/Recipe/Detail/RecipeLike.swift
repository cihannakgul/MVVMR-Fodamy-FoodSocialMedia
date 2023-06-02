//
//  RecipeLike.swift
//  DataProvider
//
//  Created by cihan on 31.05.23.
//

 

public struct RecipeLikeRequest: ApiDecodableResponseRequest {
    
    public typealias ResponseType = TextResponse
    
    public var path: String = "recipe/{recipeId}/like"
    public var method: RequestMethod = .post
    public let likeType: LikeType
    
    public init(recipeId: Int, likeType: LikeType) {
        self.path = "recipe/\(recipeId)/like"
        self.likeType = likeType
        switch likeType {
        case .like:
            method = .post
        case .unlike:
            method = .delete
        }
    }
    
    public enum LikeType {
        case like
        case unlike
    }
    
}
