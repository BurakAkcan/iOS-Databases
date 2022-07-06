//
//  Employee.swift
//  RealmDatabaseDemo
//
//  Created by Burak AKCAN on 4.07.2022.
//

import Foundation
import RealmSwift

class Employee:Object{
    @Persisted  var employeId = UUID().uuidString
    @Persisted var name = ""
    @Persisted var role = ""
    
    convenience init(name:String,role:String){
        self.init()
        self.name = name
        self.role = role
    }
    
//    override static func primaryKey() -> String? {
//        return "employeeId"
//    }
    override class func indexedProperties() -> [String] {
        return ["role"]
    }
}
