//
//  UserList.swift
//  RandomPeopleDemo
//
//  Created by Boyko Andrey on 5/28/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import Foundation
import RealmSwift

class UserList: BaseModel{
    let users = List<User>()
    dynamic var page: Int = 0
}
