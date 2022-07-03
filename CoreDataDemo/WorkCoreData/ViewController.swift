//
//  ViewController.swift
//  WorkCoreData
//
//  Created by Burak AKCAN on 1.07.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  //  let context = appDelgate.persistentContainer.viewContext
    var items:[Person]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Acces Persistent Container
        tableView.delegate = self
        tableView.dataSource = self
        
        fetcPeople()
        
        
        
        
            
    }
    
    
    
    
    
    func fetcPeople(){
        do{
            let request = Person.fetchRequest()
          //  self.items =  try context.fetch(Person.fetchRequest())
            
            //For filter and sorting
            //Sadece name ali olan object gelecek
          //  let pred = NSPredicate(format: "name CONTAINS %@","ali")
          // request.predicate = pred
          
          //For sorting
            
            let sort = NSSortDescriptor(key: "name", ascending: true)
//NsSorting liste olmasının sebebi name aynı olan kişiler varsa ondan sonra nasıl sıralıyım demek
            request.sortDescriptors = [sort]
            
          
            self.items = try context.fetch(request)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func relationshipDemo(){
        //Create family
        let family = Family(context: context)
        family.name = "Koç"
        //Create person
        let person = Person(context: context)
        person.name = "ali"
        person.age = 40
        person.gender = "Male"
        person.family = family
        
        // Another way
        family.addToPeople(person)
    //Save context
        
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Persn", message: nil, preferredStyle: .alert)
        alert.addTextField { text in
            text.placeholder = "Person name"
        }
        let action = UIAlertAction(title: "Add", style: UIAlertAction.Style.default) { action in
            let textField = alert.textFields![0]
            
            let newPerson = Person(context: self.context)
            newPerson.name = textField.text
            newPerson.age = 20
            newPerson.gender = "Male"
            
            // Save Data
            do{
                try self.context.save()
            }catch{
                print(error.localizedDescription)
            }
            
            self.fetcPeople()
                
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let person = items?[indexPath.row]
        cell.textLabel?.text = person?.name ?? "boş"
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            let personRemove = self.items?[indexPath.row]
            self.context.delete(personRemove!)
            
            //Save data
            do{
                try self.context.save()
            }catch{
                print(error.localizedDescription)
            }
            
            self.fetcPeople()
            
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    //Update Object
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = items?[indexPath.row]
        
        guard let person = person else{return }
        
        let alert = UIAlertController(title: "Update", message: nil, preferredStyle: .alert)
        alert.addTextField()
        let textField = alert.textFields![0]
        textField.text = person.name
        let action = UIAlertAction(title: "Update Data", style: UIAlertAction.Style.default) { action in
            person.name = textField.text
            do{
           try self.context.save()
            }catch{
                print(error.localizedDescription)
            }
            self.fetcPeople()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    


}
//Veritabanımızı oluştururken eğer codegen kısmını manual yapıp Editor Create NsObject dedikten sonra otomatik olark Crud işlemlerini yapabilmek için veritabı sınıfları otomatik olarak generate edilir
//Fakat codegen kısmını Class Defination yaparsam bu iki otomatik oluşan sınıf gözükmez arka planda oluşturulur bunu yaparsam oluşturulan sınıfı modife edemem yine yeni eleman ekleyebilirm tabi
