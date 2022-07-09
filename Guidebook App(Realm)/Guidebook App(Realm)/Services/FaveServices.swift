//
//  FaveServices.swift
//  Guidebook App(Realm)
//
//  Created by Burak AKCAN on 9.07.2022.
//

import Foundation
import RealmSwift


class FaveService{
    static var fave:Fave = {
        let realm = try! Realm()
        var f = realm.objects(Fave.self).first
        if f != nil {
            return f!
        }else{
            f = Fave()
            //Add the new Fave object
            try! realm.write({
                realm.add(f!)
            })
            return f!
        }
    }()
    static func getFavePlaces()->Results<Place>{
        //Get the reference to the plac realm file
        let realm = try! Realm()
        let results = realm.objects(Place.self).filter("placeId IN %@", fave.favePlaceIds)
        return results
        
    }
    static func toggleFave(_ placeId:String){
        let realm = try! Realm()
        
        //Check if this placeId is in the faves list
        let index = fave.favePlaceIds.index(of: placeId)
        
        try! realm.write({
            if index == nil {
                fave.favePlaceIds.insert(placeId, at: 0)
            }else{
                fave.favePlaceIds.remove(at: index!)
            }
        })
       
    }
    
}
