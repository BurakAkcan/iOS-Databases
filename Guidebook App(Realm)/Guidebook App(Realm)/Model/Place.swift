//
//  Place.swift
//  Guidebook App(Realm)
//
//  Created by Burak AKCAN on 7.07.2022.
//

import Foundation
import RealmSwift

class Place:Object{
    @Persisted var placeId:String?
    @Persisted var name:String?
    @Persisted var address:String?
    @Persisted var summary:String?
    @Persisted var lat:Double
    @Persisted var long:Double
    @Persisted var filename:String?
    
    convenience init(placeId:String,name:String,address:String,summary:String,lat:Double,long:Double,filename:String){
        self.init()
        self.placeId = placeId
        self.name = name
        self.address = address
        self.lat = lat
        self.long = long
        self.filename = filename
    }
    
    
}
