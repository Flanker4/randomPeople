//
//  BaseModel.swift
//  proveng
//
//  Created by Виктория Мацкевич on 27.08.16.
//  Copyright © 2016 Provectus. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import Realm


class BaseModel: Object {
    
    dynamic var modifyDate: Date? = nil
}

extension BaseModel {
    
    static func realmWrite(_ handler: () -> Void) throws -> Void  {
        let realm = RLMRealm.default()
        realm.beginWriteTransaction()
        handler()
        try realm.commitWriteTransaction()
    }
    
    static func objectRealmWrite(realm: Realm?, handler: @escaping () -> Void) throws -> Void{
        try realm?.write() {
            handler()
        }
    }
    
//    static func mappedCopy<T:Object>(_ object: T, context: Bool = true) throws -> Void {
//            if context {
//                return MapperPromise<T>().mapToJsonPromise(object, context: ContextType.write)
//            } else  {
//                return MapperPromise<T>().mapToJsonPromiseWithoutContext(object)
//            }
//        }.then { JSON -> Promise<T> in
//            return MapperPromise<T>().mapFromJSONPromise(JSON as [String : AnyObject])
//        }
//    }
}

