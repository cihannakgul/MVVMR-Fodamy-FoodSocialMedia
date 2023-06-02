//
//  UserFollow.swift
//  DataProvider
//
//  Created by cihan on 31.05.23.
//

 
public struct UserFollowRequest: ApiDecodableResponseRequest {
 
    
    public typealias ResponseType = TextResponse
    
    public var path: String = "user/{followedId}/following"
    public var method: RequestMethod = .post
    
    public init(followedId: Int, followType: FollowType) {
        self.path = "user/\(followedId)/following"
        switch followType {
        case .follow:
            method = .post
        case .unfollow:
            method = .delete
        }
    }
    
    public enum FollowType {
        case follow
        case unfollow
    }
    
}
