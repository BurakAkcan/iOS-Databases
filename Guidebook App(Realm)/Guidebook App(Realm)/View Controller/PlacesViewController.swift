//
//  PlacesViewController.swift
//  Guidebook App(Realm)
//
//  Created by Burak AKCAN on 7.07.2022.
//

import UIKit
import RealmSwift

class PlacesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var places : Results<Place>?
    let realm = try! Realm()
    var faves:Results<Place>?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        places = PlaceService.getPlaces()
        print(places!)
        print(Realm.Configuration.defaultConfiguration.fileURL?.absoluteString)
        //
        faves = FaveService.getFavePlaces()
       

    }
    

    

}
extension PlacesViewController{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if faves!.count > 0{
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.numberOfSections > 1 && section == 0{
            return faves != nil ? faves!.count : 0
        }else{
            return places != nil ? places!.count : 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlaceCell
        var p:Place?
        if tableView.numberOfSections > 1 && indexPath.section == 0{
            //There ara 2 section , its asking about first section
           p = faves![indexPath.row]
        }else{
            //There are only 1 section
            p = places![indexPath.row]
        }
        
        
       
            cell.showPlace(p!)
            return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard places != nil && tableView.indexPathForSelectedRow != nil else{return}
        if segue.identifier == Constant.Storyboard.detailSegue {
            let detailVC = segue.destination as? DetailViewController
            if let detailVC = detailVC {
                //Set the place
                detailVC.place = places![tableView.indexPathForSelectedRow!.row]
            }
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constant.Storyboard.detailSegue, sender: nil)
   
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Get te place
        var p:Place?
        
        if tableView.numberOfSections > 1 && indexPath.section == 0{
            p=faves![indexPath.row]
        }else{
            p=places![indexPath.row]
        }
        var actionTitle = ""
        if tableView.numberOfSections > 1 && indexPath.section == 0 {
            actionTitle = "Unfave"
        }else if faves!.index(of: p!) != nil {
            actionTitle = "Unfave"
        }
        
        else{
            actionTitle = "Fave"
        }
        let rowAction = UITableViewRowAction(style: .default, title: actionTitle) { action, indexPath in
            FaveService.toggleFave(p!.placeId!)
            
            self.faves = FaveService.getFavePlaces()
            
            //Reload table view
            self.tableView.reloadData()
        }
        return [rowAction]
        
    }
    
   
}
