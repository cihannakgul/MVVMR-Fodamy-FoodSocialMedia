//
//  CategoryImage.swift
//  DataProvider
//
//  Created by cihan on 04.05.23.
//

public struct CategoryImage: Decodable {
    public let url: String?

    enum CodingKeys: String, CodingKey {
        case url
    }
}
