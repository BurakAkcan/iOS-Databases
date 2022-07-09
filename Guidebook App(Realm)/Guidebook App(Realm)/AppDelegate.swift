//
//  AppDelegate.swift
//  Guidebook App(Realm)
//
//  Created by Burak AKCAN on 7.07.2022.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let realm = try! Realm()



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      preloadData()
        
        return true
    }
    // MARK: - Preload data
    
    private func preloadData(){
        let defaults = UserDefaults.standard
        
        if defaults.bool(forKey: "firstData") == false {
            let path = Bundle.main.path(forResource: "preload", ofType: "json")
            guard path != nil else {return}
            let url = URL(fileURLWithPath: path!)
            //get data
            do{
                let data = try Data(contentsOf: url)
                let jsonArray = try JSONSerialization.jsonObject(with: data,options: .mutableContainers) as! [[String:Any]]
                print(jsonArray)
                for json in jsonArray {
                    let p = Place()
                    p.placeId = json["placeId"] as? String
                    p.name = json["name"] as? String
                    p.address = json["address"] as? String
                    p.lat = json["lat"] as! Double
                    p.long = json["long"] as! Double
                    p.summary = json["summary"] as? String
                    p.filename = json["filename"] as? String
                    try! realm.write({
                        realm.add(p)
                    })
                    
                    
                }
                
                
            }catch{
                
            }
            //Save data to realm
           
            
            defaults.set(true, forKey: "firstData")
            
            
            
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

