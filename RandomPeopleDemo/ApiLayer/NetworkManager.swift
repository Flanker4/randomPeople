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
    static let URLHost = "proveng.cloud.provectus-it.com"
    static let URLScheme = "http"
}

class NetworkManager {
    let host: String
    let scheme: String
    let manager: Alamofire.SessionManager

    
    init(scheme: String = NetworkConstant.URLScheme, host: String = NetworkConstant.URLHost ) {
        self.scheme = scheme
        self.host = host
        self.manager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
        
    }
    
    public func sendNetworkRequest<T : BaseMappable>(request: NetworkRequestProtocol, completionHandler: @escaping (DataResponse<[T]>) -> Void) -> NetworkOperationProtocol? {
        let path = request.path
        let parameters = request.params
        
        var urlComponents =  URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.host = self.host
        urlComponents.path =  path
        //urlComponents.queryItems = parameters.queryItems
        guard let urlRequest = urlComponents.url else {
            return nil
        }
        return self.manager.request(urlRequest).responseArray(completionHandler: completionHandler)
    }
}

//
//extension Dictionary where Key == String {
//    var queryItems: [URLQueryItem] {
//        var result:[URLQueryItem] = []
//        for (key, value) in self {
//            result.append(URLQueryItem(name: key, value: value as? String));
//        }
//        return result
//    }
//}

extension DataRequest: NetworkOperationProtocol  {
    
}
