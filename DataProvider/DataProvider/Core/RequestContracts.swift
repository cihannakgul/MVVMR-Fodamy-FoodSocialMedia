//
//  RequestContracts.swift
//  DataProvider
//
//  Created by cihan on 03.05.23.
//


public protocol RequestContracts { // Request Contracts for Request
    associatedtype ResponseType: Decodable
    var path: String { get }
    var method: RequestMethod { get }
    var parameters: [String: Any] { get }
    var headers: [String: String] { get }
    var encoding: RequestEncoding { get }
    var url: String { get }
}
 


