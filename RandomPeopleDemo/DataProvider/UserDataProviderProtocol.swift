
//
//  File.swift
//  RandomPeopleDemo
//
//  Created by aboyko on 5/29/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import Foundation
import RealmSwift

protocol DataProvider {
    associatedtype T: Object
    func item(id:Any)-> Result<T>
    var items:Result<List<T>> {get}
}
