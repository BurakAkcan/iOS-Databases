//
//  PlaceService.swift
//  Guidebook App(Realm)
//
//  Created by Burak AKCAN on 8.07.2022.
//

import Foundation
import RealmSwift

class PlaceService{
    static func getPlaces()->Results<Place>{
        let realm = try! Realm()
        return realm.objects(Place.self)
        
    }
}
