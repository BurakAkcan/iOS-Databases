//
//  Note.swift
//  Guidebook App(Realm)
//
//  Created by Burak AKCAN on 7.07.2022.
//

import Foundation
import RealmSwift

class Note:Object{
    @objc dynamic var placeId:String?
    @objc dynamic var date:String?
    @objc dynamic var text:String?
    
    
//    convenience init(placeId:String,date:String,text:String){
//        self.init()
//        self.placeId = placeId
//        self.date = date
//        self.text = text
//    }
     
    
}
