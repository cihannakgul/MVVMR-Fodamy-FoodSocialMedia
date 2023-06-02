//
//  Pagination.swift
//  DataProvider
//
//  Created by cihan on 04.05.23.
//

import Foundation

public struct Pagination: Decodable {
    public let currentPage: Int
    public let lastPage: Int
    
    enum CodingKeys: String, CodingKey {
        case lastPage = "last_page"
        case currentPage = "current_page"
    }
}
