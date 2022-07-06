//
//  Directory.swift
//  RealmDatabaseDemo
//
//  Created by Burak AKCAN on 5.07.2022.
//

import Foundation
import RealmSwift

class Directory:Object{
    var allEmployees = List<Employee>()
      var allDesigner = List<Employee>()
     var allDevelopers = List<Employee>() 
}
