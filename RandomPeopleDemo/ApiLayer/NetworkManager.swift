//
//  NetworkManager.swift
//  RandomPeopleDemo
//
//  Created by Boyko Andrey on 5/28/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper


class NetworkManager: NetworkManagerProtocol {
    private let host: String
    private let scheme: String
    private let manager: Alamofire.SessionManager


    init(scheme: String, host: String) {
        self.scheme = scheme
        self.host = host
        self.manager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)

    }

    final func url(request: NetworkRequestProtocol) -> URL? {
        let path = request.path
        let parameters = request.params

        var urlComponents = URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.host = self.host
        urlComponents.path = path
        urlComponents.queryItems = parameters.queryItems
        return urlComponents.url
    }

    public func sendNetworkRequest<T:BaseMappable>(request: NetworkRequestProtocol,
                                                   completionHandler: @escaping (Result<[T]>) -> Void) -> NetworkOperationProtocol? {

        guard let urlRequest = self.url(request: request) else {
            return nil
        }
        return self.manager.request(urlRequest).responseArray(keyPath: CommonKeys.results.key) { (response:DataResponse<[T]>) in
            completionHandler(response.result)
        }
    }
}


extension DataRequest: NetworkOperationProtocol {

}
