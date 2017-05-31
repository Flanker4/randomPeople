//
//  File.swift
//  RandomPeopleDemo
//
//  Created by Boyko Andrey on 5/28/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }

    class var className: String {
        return String(describing: self)
    }
}

///Demonstration of the global function which can be reused in the different parts of application
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
