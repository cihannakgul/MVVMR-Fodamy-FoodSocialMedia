//
//  DataProviderContracts.swift
//  DataProvider
//
//  Created by cihan on 03.05.23.
//

//-MARK: DataProviderContracts
// Contracts of the DataProvider

//public typealias DataProviderResult<T> = (Result<T, Error>) -> Void where T: Decodable
public typealias DataProviderResult<T: Decodable> = ((Result<T, Error>) -> Void)

public protocol DataProviderContracts {
    
    func request<T: RequestContracts>(for request: T,
                                              result: DataProviderResult<T.ResponseType>?)
}
