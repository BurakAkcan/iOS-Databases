//
//  NoteService.swift
//  Guidebook App(Realm)
//
//  Created by Burak AKCAN on 8.07.2022.
//

import Foundation
import RealmSwift
class NoteService{
    static var token:NotificationToken?
    
    static func getNotes(_ placeId:String, updates:@escaping ()->Void)->Results<Note>{
        let realm = try! Realm()

        let results = realm.objects(Note.self).filter("placeId = %@", placeId).sorted(byKeyPath: "text", ascending: false)
        
        if token != nil {
            token?.invalidate()
        }
        
       token = results.observe { (changes) in
            switch changes {
            case .initial :
                break
            case .error:
                break
            case .update:
                updates()
                
            }
        }

        return results

    }
    static func addNote(_ note:Note){
        let realm = try! Realm()
       try! realm.write {
           realm.add(note)
        }
    }
}
    
