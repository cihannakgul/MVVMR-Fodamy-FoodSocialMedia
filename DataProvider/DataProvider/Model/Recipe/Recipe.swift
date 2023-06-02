//
//  Recipe.swift
//  DataProvider
//
//  Created by cihan on 03.05.23.
//


public struct Recipe: Decodable {
    public let id: Int
    public let likeCount: Int
    public let commentCount: Int
    public let user: User
    public let title: String?
    public let isEditorChoice: Bool
    public let category: CategoryDetail
    public let images: [Image]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case user
        case category
        case images
        case isEditorChoice = "is_editor_choice"
        case likeCount = "like_count"
        case commentCount = "comment_count"
    }
}
