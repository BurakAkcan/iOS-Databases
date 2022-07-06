//
//  EmployeeService.swift
//  RealmDatabaseDemo
//
//  Created by Burak AKCAN on 5.07.2022.
//

import Foundation
import RealmSwift

class EmployeeService{
    
   // let realm = try! Realm()

    private static var directory:Directory = {
        //Check he realm filefor an existing directory object
        let realm = try! Realm()
        var dir = realm.objects(Directory.self).first
        //if it doesnt exist,create new on
        if dir != nil {
            return dir!
        }else{
            dir = Directory()
            
            try! realm.write({
                realm.add(dir!)
            })
            
            return dir!
        }
       
    }()
    static func saveEmployee(e:Employee,roleType:String){
        let realm = try! Realm()
        
       try! realm.write {
           directory.allEmployees.append(e)
           print("kayıt yapıldı")
           
           if roleType == Constant.developer{
               directory.allDevelopers.append(e)
               print("developer kydedildi")
               
           }else if roleType == Constant.designer{
               directory.allDesigner.append(e)
               print("designer kaydedildi")
           }
        }
        
    }
    static func getEmployee(roleType:String)->List<Employee>{
        switch roleType {
            
        case "All":
            print("çağırıldı all")
            return directory.allEmployees
            
        case "Designer":
            print("çağırıldı designer")
            return directory.allDesigner
            
        case "Developer":
            print("çağırıldı developer")
            return directory.allDevelopers
        default :
            return directory.allEmployees
        }
    }
    static func deleteItem(item:Employee){
        let realm = try! Realm()
        
        try! realm.write({
            realm.delete(item)
        })
    }
}
