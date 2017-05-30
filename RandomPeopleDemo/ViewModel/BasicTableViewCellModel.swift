//
//  UserDetailsViewController.swift
//  RandomPeopleDemo
//
//  Created by aboyko on 5/29/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import Foundation

struct BasicTableViewCellModel {
    let title: String
    let imageURL: URL?
}

extension User {
    func basicTableViewCellModel() -> BasicTableViewCellModel {
        let fullName = createFullName(firstName: self.firstName, lastName: self.lastName)
        return BasicTableViewCellModel(title: fullName, imageURL: self.pictureThumbnail)
    }
}

func createFullName(firstName: String?, lastName: String?) -> String {
    var fullNameComponents: [String] = []
    if let firstName = firstName {
        fullNameComponents.append(firstName)
    }
    if let lastName = lastName {
        fullNameComponents.append(lastName)
    }
    return fullNameComponents.map {
        $0.capitalized
    }.joined(separator: " ")
}
