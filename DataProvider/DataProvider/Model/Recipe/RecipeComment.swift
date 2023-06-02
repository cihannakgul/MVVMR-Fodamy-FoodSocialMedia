//
//  RecipeComment.swift
//  DataProvider
//
//  Created by cihan on 01.06.23.
//

public struct RecipeComment: Decodable {
    public let id: Int
    public let text: String?
    public let timeDifference: String?
    public let user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case timeDifference = "difference"
        case user
    }
}

