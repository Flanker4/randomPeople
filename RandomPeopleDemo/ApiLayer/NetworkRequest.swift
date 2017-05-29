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
            return ["page": String(page), "results": "5", "seed": "pagination"]
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


enum UserKeys: String{
    case email
    case name
    case first
    case last
    case gender
    case picture
    case large
    case thumbnail
    
    var key: String {
        return self.rawValue
    }
    
    func dot(_ key:UserKeys) -> String {
        return "\(self.key).\(key.key)"
    }
}
