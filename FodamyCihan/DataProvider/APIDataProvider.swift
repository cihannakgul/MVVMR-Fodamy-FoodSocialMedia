//
//  APIDataProvider.swift
//  FodamyCihan
//
//  Created by cihan on 01.05.23.
//

import Alamofire
import DataProvider

public struct APIDataProvider: DataProviderContracts {
    
    private let interceptor: RequestInterceptor?
    private let session: Session
    
    public init(interceptor: RequestInterceptor? = nil,
                eventMonitors: [EventMonitor] = []) {
        self.interceptor = interceptor
        self.session = Session(interceptor: interceptor, eventMonitors: eventMonitors)
        self.session.sessionConfiguration.timeoutIntervalForRequest = 20
    }
    
    private func createRequest<T: RequestContracts>(_ request: T) -> DataRequest {
        let adapter = APIRequestAdapter(request: request)
        let request = session.request(adapter.url,
                                      method: adapter.method,
                                      parameters: adapter.parameters,
                                      encoding: adapter.encoding,
                                      headers: adapter.headers)
        return request
    }
    
    public func request<T: RequestContracts>(for request: T, result: DataProviderResult<T.ResponseType>? = nil) {
        let request = createRequest(request)
        request.validate()
        request.responseDecodable(of: T.ResponseType.self) { (response) in
            switch response.result {
            case .success(let value):
                result?(.success(value))
            case .failure(let error):
                result?(.failure(error))
            }
        }
    }
    
}
