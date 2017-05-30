//
//  LocalStorage.swift
//  RandomPeopleDemo
//
//  Created by aboyko on 5/30/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm: LocalStorageProtocol {
    var userList: Result<UserList> {
        get {
            guard let userList = self.objects(UserList.self).first else {
                return .failure(LocalStorageError.objectNotFound)
            }
            return .success(userList)
        }
        set(newUserList) {
            guard let newList = newUserList.value else {
                return
            }
            self.beginWrite()
            self.add(newList)
            //TODO: handle error
            try! self.commitWrite()
        }
    }

    func addUsers(users: Result<[User]>, toUserList: UserList?) -> Result<[User]> {
        guard let toUserList = toUserList else {
            return .failure(LocalStorageError.objectNotFound)
        }

        switch users {
        case .success(let users):
            self.beginWrite()
            toUserList.users.append(objectsIn: users)
            toUserList.page += 1
            do {
                try self.commitWrite()
            } catch {
                return .failure(LocalStorageError.writeError)
            }
        case .failure(_):
            return users
        }

        return users
    }
}
