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

class UserDataProvider {
    
    
    var users: List<User>{
        get {
            return self.userList.users
        }
    }
    
    fileprivate let userList: UserList
    fileprivate let localStorage: Realm
    fileprivate let networkManager: NetworkManagerProtocol
    
    init(localStorage: Realm, networkManager: NetworkManager) {
        self.localStorage = localStorage
        self.networkManager = networkManager
        
        if let userList = self.localStorage.objects(UserList.self).first {
            self.userList = userList;
        }else{
            self.userList = UserList()
            self.localStorage.beginWrite()
            self.localStorage.add(self.userList)
            try! self.localStorage.commitWrite()
        }
        
        self.getUsers()
       
    }
    
    func getUsers(){
        let request = NetworkRequest.getUsers(page: userList.page)
        networkManager.sendNetworkRequest(request: request) {[weak self] (response: DataResponse<[User]>) in
            switch response.result {
            case .success(let value):
                self?.localStorage.beginWrite()
                self?.userList.users.append(objectsIn: value)
                self?.userList.page += 1
                try! self?.localStorage.commitWrite()
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func userWithId(userId: String) -> User? {
        return self.localStorage.object(ofType: User.self, forPrimaryKey: userId)
    }
    
}
