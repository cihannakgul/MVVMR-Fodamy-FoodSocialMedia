//
//  APIDecodableResponseRequest.swift
//  DataProvider
//
//  Created by cihan on 10.04.23.
//
//-MARK: APIDecodableResponseRequest

public protocol ApiDecodableResponseRequest: RequestContracts {} // ResponseRequest which confirm of the Contracts


// MARK: - RequestEncoding
public extension ApiDecodableResponseRequest {
    var encoding: RequestEncoding {
        switch method {
        case .get:
            return .url
        default:
            return .json
        }
    }
}

// MARK: - Url
public extension ApiDecodableResponseRequest {
    var url: String {
        return "https://fodamy.mobillium.com/api/" + path
    }
}

// MARK: - RequestParameters
public extension ApiDecodableResponseRequest {
    var parameters: [String: Any] {
        return [:]
    }
}

// MARK: - RequestHeaders
public extension ApiDecodableResponseRequest {
    var headers: [String: String] {
        return [:]
    }
}
