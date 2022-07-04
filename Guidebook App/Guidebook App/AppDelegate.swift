//
//  AppDelegate.swift
//  Guidebook App
//
//  Created by Burak AKCAN on 1.07.2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        preloadData()
        return true
    }
    
  
    
    
    // MARK: Preload Data
    private func preloadData(){
        //Ref UserDefault
        let defaults = UserDefaults.standard
        //Ref CorData
        let context = persistentContainer.viewContext
        print(defaults.bool(forKey: Constants.PRELOAD_DATA))
        
    //Check if this first launch
        if defaults.bool(forKey: Constants.PRELOAD_DATA) == false {
            
            
            let path = Bundle.main.path(forResource: "preload", ofType: "json")
            
            guard path != nil else{return}
            
            let url = URL(fileURLWithPath: path!)
         
            
            //get data
            do{
                let data = try Data(contentsOf: url)
                //Try turnin data into json object
                let jsonArray = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String:Any]]
                print(jsonArray)
                for json in jsonArray{
                    let p = Place(context: context)
                    p.name = json["name"] as? String
                    p.imageName = json["imagename"] as? String
                    p.address = json["address"] as? String
                    p.lat = json["lat"] as! Double
                    p.long = json["long"] as! Double
                    p.summary = json["summary"] as? String
                }
                
            }catch{
                print(error.localizedDescription)
            }
            self.saveContext()
            //data yüklendikten onra userFefault a bool olarak kaydettiğim değişkeni artık true yapabilirim
            defaults.set(true, forKey: Constants.PRELOAD_DATA)
            
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

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Guidebook_App")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

