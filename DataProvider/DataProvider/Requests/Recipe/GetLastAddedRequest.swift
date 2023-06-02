//
//  GetLastAddedRequest.swift
//  DataProvider
//
//  Created by cihan on 04.05.23.
//

public struct GetLastAddedRequest:ApiDecodableResponseRequest {
    
    public typealias ResponseType = MainResponse<[Recipe]>
    
    public let path: String = "recipe/"
    public let method: RequestMethod = .get
    public var parameters: [String: Any] = [:]
    public let headers: [String: String] = [:]
    
    public init(page: Int) {
        self.parameters["page"] = page
    }
}
