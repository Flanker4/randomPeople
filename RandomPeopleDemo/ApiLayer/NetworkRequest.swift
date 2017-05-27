//
//  NetworkRequest.swift
//  RandomPeopleDemo
//
//  Created by Boyko Andrey on 5/28/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import Foundation

enum NetworkRequest: NetworkRequestProtocol {
    case getUsers(page: UInt)
    //other methods
 
    var path: String {
        switch self {
        case .getUsers(_):
            return ""
        }
    }
    var params: [String : AnyObject]{
        switch self {
        case .getUsers(_):
            return [:]
        }
    }
}
