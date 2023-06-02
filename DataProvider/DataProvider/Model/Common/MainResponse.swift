//
//  MainResponse.swift
//  DataProvider
//
//  Created by cihan on 04.05.23.
//

import Foundation

public struct MainResponse<T: Decodable>: Decodable where T: Decodable {
    public let data: T
    public let pagination: Pagination
}
