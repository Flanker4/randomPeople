//
//  User.swift
//  RandomPeopleDemo
//
//  Created by Boyko Andrey on 5/28/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import Foundation
import ObjectMapper

class User: BaseModel {
    dynamic var firstName: String? = nil
    dynamic var lastName: String? = nil
    dynamic var email: String? = nil
    
    //private
    fileprivate dynamic var _pictureLarge: String?
    fileprivate dynamic var _pictureThumbnail: String?
    fileprivate dynamic var _gender = Gender.unknown.rawValue

}


extension User: StaticMappable{
    func mapping(map: Map) {
        firstName     <- map["name.first"]
        lastName      <- map["name.last"]
        email         <- map["email"]
        _gender       <- map["gender"]
        _pictureLarge <- map["picture.large"]
        _pictureThumbnail <- map["picture.thumbnail"]
    }

    class func objectForMapping(map: Map) -> BaseMappable? {
        return User() //we can use object from cache
    }
}

extension User {
    var gender: Gender{
        get {
            return Gender(rawValue: _gender) ?? .unknown;
        }
    }
    
    var pictureLarge: URL? {
        get {
            guard let urlStr = _pictureLarge else {
                return nil
            }
            return URL(string: urlStr)
        }
    }
    
    var pictureThumbnail: URL? {
        get {
            guard let urlStr = _pictureThumbnail else {
                return nil
            }
            return URL(string: urlStr)
        }
    }
}

enum Gender: String {
    case unknown = "unknown"
    case female = "female"
    case male = "male"
}
