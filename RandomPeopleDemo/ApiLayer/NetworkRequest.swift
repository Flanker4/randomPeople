//
//  NetworkRequest.swift
//  RandomPeopleDemo
//
//  Created by Boyko Andrey on 5/28/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import Foundation

enum NetworkRequest: NetworkRequestProtocol {
    case getUsers(page: Int)
    //other methods

    var path: String {
        switch self {
        case .getUsers(_):
            return "/api/"
        }
    }
    var params: [String: String] {
        switch self {
        case .getUsers(let page):
            return ["page": String(page), CommonKeys.results.key: "20", "seed": "pagination"]
        }
    }
}

extension Dictionary where Key == String {
    var queryItems: [URLQueryItem] {
        var result: [URLQueryItem] = []
        for (key, value) in self {
            result.append(URLQueryItem(name: key, value: value as? String));
        }
        return result
    }
}




