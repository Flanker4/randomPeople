//
//  SwiftInjection.swift
//  RandomPeopleDemo
//
//  Created by Boyko Andrey on 5/29/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import Foundation
import SwinjectStoryboard
import RealmSwift

struct NetworkConstant {
    static let URLHost = "randomuser.me"
    static let URLScheme = "https"
}


extension SwinjectStoryboard {
    class func setup() {
        defaultContainer.storyboardInitCompleted(UserListViewController.self) { r, c in
            c.dataProvider = r.resolve(UserDataProvider.self)
        }
        defaultContainer.storyboardInitCompleted(UserDetailsViewController.self) { r, c in
            c.dataProvider = r.resolve(UserDataProvider.self)!
        }

        defaultContainer.register(NetworkManager.self) { _ in
            NetworkManager(scheme: NetworkConstant.URLScheme, host: NetworkConstant.URLHost)
        }

        defaultContainer.register(Realm.self) { r in
            try! Realm()
        }

        defaultContainer.register(UserDataProvider.self) { r in
            UserDataProvider(localStorage: r.resolve(Realm.self)!,
                    networkManager: r.resolve(NetworkManager.self)!)
        }
    }
}
