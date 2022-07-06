//
//  FirstViewController.swift
//  RealmDatabaseDemo
//
//  Created by Burak AKCAN on 4.07.2022.
//

import UIKit
import RealmSwift

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  //  var employees:[Employee] = []
    var employees : List <Employee>?
    let realm = try! Realm()

    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Configure segmentcontrol
       segmentController.addTarget(self, action: #selector(segmentChangedFunc), for: .valueChanged)
        
        
        //Configure TableView
        tableView.delegate = self
        tableView.dataSource = self
        //Configure Realm
       
        print(Realm.Configuration.defaultConfiguration.fileURL!)
       
        retrieveEmployes(role: Constant.all)
       

    }
    

  
    
    
    @objc func segmentChangedFunc(){
        switch segmentController.selectedSegmentIndex  {
        case 0:
            retrieveEmployes(role: Constant.all)
           
            
        case 1:
            retrieveEmployes(role: Constant.designer)
            
        case 2:
            retrieveEmployes(role: Constant.developer)
            
        default:
            retrieveEmployes(role: Constant.all)
        }
       
    }
    
    func retrieveEmployes(role:String){
        employees = EmployeeService.getEmployee(roleType:role)
      
        tableView.reloadData()
    }
   
    
}
 
extension FirstViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees?.isEmpty == false ? employees!.count : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = employees?[indexPath.row].name ?? "empty"
        cell.detailTextLabel?.text = employees?[indexPath.row].role ?? "empty"
        
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let selectedItem = employees?[indexPath.row]
            guard let selected = selectedItem else{return}
            EmployeeService.deleteItem(item: selected)
            tableView.reloadData()
        }
    }
    
    
    
}
