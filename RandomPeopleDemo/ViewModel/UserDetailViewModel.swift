//
//  UserDetailViewModel.swift
//  RandomPeopleDemo
//
//  Created by aboyko on 5/29/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import Foundation

struct UserDetailViewModel {
    let email: String
    let fullName: String?
    let gender: String?
    let imageURL: URL?
}

extension User {
    func userDetailViewModel() -> UserDetailViewModel {
        let fullName = createFullName(firstName: self.firstName, lastName: self.lastName)
        return UserDetailViewModel(email: self.email, fullName: fullName, gender: self.gender.rawValue.capitalized, imageURL: self.pictureLarge)
    }
}
