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

struct  NetworkConstant {
    static let URLHost = "randomuser.me"
    static let URLScheme = "https"
}

class NetworkManager: NetworkManagerProtocol {
    let host: String
    let scheme: String
    let manager: Alamofire.SessionManager

    
    init(scheme: String = NetworkConstant.URLScheme, host: String = NetworkConstant.URLHost ) {
        self.scheme = scheme
        self.host = host
        self.manager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
        
    }
    
    final func url(request: NetworkRequestProtocol) -> URL? {
        let path = request.path
        let parameters = request.params
        
        var urlComponents =  URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.host = self.host
        urlComponents.path =  path
        urlComponents.queryItems = parameters.queryItems
        return urlComponents.url
    }
    
    public func sendNetworkRequest<T : BaseMappable>(request: NetworkRequestProtocol,
                                   completionHandler: @escaping (DataResponse<[T]>) -> Void) -> NetworkOperationProtocol? {
        
        guard let urlRequest = self.url(request: request) else {
            return nil
        }
        return self.manager.request(urlRequest).responseArray(keyPath:"results" , completionHandler: completionHandler)
    }
}




extension DataRequest: NetworkOperationProtocol  {
    
}
