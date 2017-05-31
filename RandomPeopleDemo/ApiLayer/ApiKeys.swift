//
//  ApiKeys.swift
//  RandomPeopleDemo
//
//  Created by aboyko on 5/29/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import Foundation

protocol ApiKeys {
    var key: String { get }
}

extension ApiKeys where Self: RawRepresentable, Self.RawValue == String{
    var key: String {
        return self.rawValue
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
    case thumbnail = "medium"
}

enum CommonKeys: String{
    case results
}

extension UserKeys: ApiKeys {}
extension CommonKeys: ApiKeys {}

/// Demo of overloading standart operators (>> is taked just for the demo)
func >> (left: String, right: UserKeys) -> String {
    return "\(left).\(right.key)"
}
