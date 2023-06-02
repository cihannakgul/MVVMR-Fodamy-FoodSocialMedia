//
//  GetEditorChoiceRequest.swift
//  DataProvider
//
//  Created by cihan on 09.05.23.
//

import Foundation
public struct GetEditorChoiceRequest: ApiDecodableResponseRequest {
    
    public typealias ResponseType = MainResponse<[Recipe]>
    
    public let path: String = "editor-choices"
    public let method: RequestMethod = .get
    public var parameters: [String: Any] = [:]
    public let headers: [String: String] = [:]

    public init(page: Int) {
        self.parameters["page"] = page
    }
}
