//
//  GetCategoryRequest.swift
//  DataProvider
//
//  Created by cihan on 09.05.23.
//

import Foundation

public struct GetCategoryRequest: ApiDecodableResponseRequest {
    
    public typealias ResponseType = MainResponse<[Recipe]>
    
    public var path: String = ""
    public let method: RequestMethod = .get
    public var parameters: [String: Any] = [:]
    public let headers: [String: String] = [:]
    
    public init(page: Int, categoryId: Int) {
        self.path = "category/\(categoryId)/recipe"
        self.parameters["page"] = page
    }
}
