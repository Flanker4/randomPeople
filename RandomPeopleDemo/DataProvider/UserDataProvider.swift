//
//  UserDataProvider.swift
//  RandomPeopleDemo
//
//  Created by Boyko Andrey on 5/28/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import Foundation
import Alamofire
import Realm
import RealmSwift
import ObjectMapper

class UserDataProvider {
    
    fileprivate let userList: UserList
    fileprivate var localStorage: LocalStorageProtocol
    fileprivate let networkManager: NetworkManagerProtocol
    fileprivate var notificationToken: NotificationToken? = nil

    var isRequiredUpdateCache:Bool {
        get {
            //example of method which tells that we need download additional data
            //also we need to drop old cache self.localStorage.dropCache(self.userList)
            return (self.items.value?.count == 0)
        }
    }
    var changeNotificationBlock: ((Result<List<User>>) -> Void)? {
        didSet {
            guard let _ = changeNotificationBlock else {
                self.notificationToken?.stop()
                self.notificationToken = nil
                return
            }

            self.notificationToken = self.items.value?.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
                guard let strongSelf = self else {
                    return
                }
                switch changes {
                case .error(let error):
                    strongSelf.changeNotificationBlock?(.failure(error))
                default:
                    strongSelf.changeNotificationBlock?(strongSelf.items)
                }

            }

        }
    }

    init(localStorage: Realm, networkManager: NetworkManager) {
        self.localStorage = localStorage
        self.networkManager = networkManager

        if let userList = self.localStorage.userList.value {
            self.userList = userList;
        } else {
            self.userList = UserList()
            self.localStorage.userList = .success(self.userList)
        }
    }

    var items: Result<List<User>> {
        get {
            return Result.success(self.userList.users)
        }
    }
    
    func getUsers(handler: ((Result<[User]>) -> Void)?) {
        let request = NetworkRequest.getUsers(page: userList.page)
        networkManager.sendNetworkRequest(request: request) { [weak self] (result: Result<[User]>) in
            let result = self?.localStorage.addUsers(users: result, toUserList: self?.userList)
            if let result = result {
                handler?(result)
            }
        }
    }
    
    deinit {
        self.changeNotificationBlock = nil
    }


}

