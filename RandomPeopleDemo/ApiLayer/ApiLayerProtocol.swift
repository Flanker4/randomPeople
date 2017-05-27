//
//  ApiLayerProtocol.swift
//  RandomPeopleDemo
//
//  Created by Boyko Andrey on 5/28/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import Foundation
import Alamofire
protocol NetworkRequestProtocol {
    var path: String { get }
    var params: [String: AnyObject] { get }
}

protocol NetworkOperationProtocol {
    func cancel()
}

protocol NetworkManagerProtocol {
    func sendNetworkRequest<T>(request: NetworkRequestProtocol, completionHandler: @escaping (DataResponse<T>)->Void) -> NetworkOperationProtocol?
}
