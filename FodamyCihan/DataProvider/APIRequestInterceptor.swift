//
//  APIRequestInterceptor.swift
//  FodamyCihan
//
//  Created by cihan on 01.05.23.
//

import Alamofire
import KeychainSwift

public class APIRequestInterceptor: RequestInterceptor {
    
    public static let shared = APIRequestInterceptor()
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        let accessToken = KeychainSwift().get(Keychain.token)
        
        if let accessToken = accessToken {
            urlRequest.headers.add(name: "X-Fodamy-Token", value: accessToken)
        }

        completion(.success(urlRequest))
    }
}

public struct Keychain {
    public static let token = "token"
}
