//
//  ViewController.swift
//  Guidebook App
//
//  Created by Burak AKCAN on 1.07.2022.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
   private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var places = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //Get the places
        
        do{
            let request = Place.fetchRequest()
            let sort =  NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sort]
            places = try context.fetch(request)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if tableView.indexPathForSelectedRow == nil {
            return
        }
        let selectedPlace = self.places[tableView.indexPathForSelectedRow!.row]
       let placeVC = segue.destination as! PlaceViewController
        placeVC.place = selectedPlace
    }

}

extension ViewController{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        places.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlaceTableViewCell
        cell.setCell(places[indexPath.row])
        return cell
        
    }
}
