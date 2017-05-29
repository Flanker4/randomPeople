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
    dynamic var email: String = "" //example of required field

    //private
    fileprivate dynamic var _pictureLarge: String?
    fileprivate dynamic var _pictureThumbnail: String?
    fileprivate dynamic var _gender = Gender.unknown.rawValue

    required convenience init?(map: Map) {
        guard let _ = map.JSON[UserKeys.email.key] else {
            return nil
        }
        self.init()
    }

}

extension User: Mappable {
    func mapping(map: Map) {
        firstName           <- map[UserKeys.name.key * .first]
        lastName            <- map[UserKeys.name.key * .last]
        email               <- map[UserKeys.email.key]
        _gender             <- map[UserKeys.gender.key]
        _pictureLarge       <- map[UserKeys.picture.key * .large]
        _pictureThumbnail   <- map[UserKeys.picture.key * .thumbnail]
    }

    class func objectForMapping(map: Map) -> BaseMappable? {
        return User(map: map)
    }
}

extension User {
    var gender: Gender {
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
