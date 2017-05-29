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
    fileprivate let localStorage: Realm
    fileprivate let networkManager: NetworkManagerProtocol
    fileprivate var notificationToken: NotificationToken? = nil
    
    var changeNotificationBlock: ((Result<List<User>>)-> Void)? {
        didSet{
            guard let _ = changeNotificationBlock else{
                self.notificationToken?.stop()
                self.notificationToken = nil
                return
            }
            
            self.notificationToken = self.items.value?.addNotificationBlock{ [weak self] (changes: RealmCollectionChange) in
                
                switch changes {
                case .error(let error):
                    self?.changeNotificationBlock?(Result.failure(error))
                default:
                    self?.changeNotificationBlock?((self?.items)!)
                }
                
            }

        }
    }
    
    
    init(localStorage: Realm, networkManager: NetworkManager) {
        self.localStorage = localStorage
        self.networkManager = networkManager

        if let userList = self.localStorage.objects(UserList.self).first {
            self.userList = userList;
        } else {
            self.userList = UserList()
            self.localStorage.beginWrite()
            self.localStorage.add(self.userList)
            try! self.localStorage.commitWrite()
        }
        self.getUsers()
    }

    func getUsers() {
        let request = NetworkRequest.getUsers(page: userList.page)
        networkManager.sendNetworkRequest(request: request) { [weak self] (result: Result<[User]>) in
            switch result {
            case .success(let value):
                self?.localStorage.beginWrite()
                self?.userList.users.append(objectsIn: value)
                self?.userList.page += 1
                //TODO remove force unwrap
                try! self?.localStorage.commitWrite()

            case .failure(let error):
                self?.changeNotificationBlock?(.failure(error))
            }
        }
    }
    
    deinit {
        self.changeNotificationBlock = nil
    }
    

}

extension UserDataProvider: DataProvider {
    typealias T = User
    
    var items: Result<List<User>> {
        get {
            return Result.success(self.userList.users)
        }
    }
    
    func item(id: Any) -> Result<User> {
        
        guard let item = self.localStorage.object(ofType: User.self, forPrimaryKey: id) else {
            return Result.failure(NSError(domain: "", code: 0, userInfo: nil))
        }
        return Result.success(item)

    }
}
