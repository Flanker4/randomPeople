//
//  ApiLayerProtocol.swift
//  RandomPeopleDemo
//
//  Created by Boyko Andrey on 5/28/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol NetworkRequestProtocol {
    var path: String { get }
    var params: [String: String] { get }
}

protocol NetworkOperationProtocol {
    func cancel()
}

protocol NetworkManagerProtocol {
    @discardableResult func sendNetworkRequest<T : BaseMappable>(request: NetworkRequestProtocol,
                            completionHandler: @escaping (DataResponse<[T]>) -> Void) -> NetworkOperationProtocol?
}
