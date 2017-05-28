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
    private let userList: UserList
    
    var users: List<User>{
        get {
            return self.userList.users
        }
    }
    
    let localStorage: Realm
    let networkManager: NetworkManagerProtocol
    
    init() {
        localStorage = try! Realm()
        networkManager = NetworkManager()
        
        if let userList = self.localStorage.objects(UserList.self).first {
            self.userList = userList;
        }else{
            self.userList = UserList()
            self.localStorage.beginWrite()
            self.localStorage.add(self.userList)
            try! self.localStorage.commitWrite()
        }
        
        if (self.userList.users.count==0){
            self.getUsers()
        }
    }
    
    func getUsers(){
        let request = NetworkRequest.getUsers(page: userList.page)
        networkManager.sendNetworkRequest(request: request) {[weak self] (response: DataResponse<[User]>) in
            switch response.result {
            case .success(let value):
                self?.localStorage.beginWrite()
                self?.userList.users.append(objectsIn: value)
                
                try! self?.localStorage.commitWrite()
            
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
}
