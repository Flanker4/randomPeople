//
//  BaseModel.swift
//  proveng
//
//  Created by Виктория Мацкевич on 27.08.16.
//  Copyright © 2016 Provectus. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import Realm


class BaseModel: Object {
    dynamic var modifyDate: Date? = nil
    dynamic var objectId = UUID().uuidString
    override class func primaryKey() -> String? {
        return "objectId"
    }
}

