//
//  LocalStorageProtocol.swift
//  RandomPeopleDemo
//
//  Created by aboyko on 5/30/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import Foundation

enum LocalStorageError: Error {
    case objectNotFound
    case writeError
}

protocol LocalStorageProtocol {
    var userList: Result<UserList> { get set }

    func addUsers(users: Result<[User]>, toUserList: UserList?) -> Result<[User]>
    
    func dropCache(userList:UserList ) -> Result<Bool>
}

