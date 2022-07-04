//
//  NotesViewController.swift
//  Guidebook App
//
//  Created by Burak AKCAN on 1.07.2022.
//

import UIKit
import CoreData

class NotesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var noteTableView: UITableView!
    var place:Place?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchedNoteRC:NSFetchedResultsController<Note>?

    override func viewDidLoad() {
        super.viewDidLoad()
        noteTableView.delegate = self
        noteTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       refresh()
        noteTableView.reloadData()
    }
    
    func refresh(){
        //Check
        if let place = place{
            //Get fetchRequest
            let request:NSFetchRequest<Note> = Note.fetchRequest()
            //only get this place notes
            request.predicate = NSPredicate(format: "place = %@", place)
            //set sortdescriptor
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
            //create fectResult controller
            
            do{
             fetchedNoteRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            //Excute fetch
                try fetchedNoteRC!.performFetch()
            }catch{
                print(error.localizedDescription)
            }
            noteTableView.reloadData()
        }
    }
    
    @IBAction func addNoteButton(_ sender: UIButton) {
        let addNoteVC = storyboard?.instantiateViewController(withIdentifier: Constants.ADD_NOTE_VIEWCONTROLLER) as! AddNoteViewController
        //Set self as delegate so we can get notified of a new note
        addNoteVC.delegate = self
        
        addNoteVC.place = place
        
        //Configure popup mode
        addNoteVC.modalPresentationStyle = .overCurrentContext
        
        //Present
        present(addNoteVC, animated: true, completion: nil)
        
    }
    
    

}
extension NotesViewController:AddNoteDelegatee{
    func noteAdded() {
        refresh()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedNoteRC?.fetchedObjects?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = noteTableView.dequeueReusableCell(withIdentifier: "noteCell",for:indexPath)
        let dateLabel = cell.viewWithTag(1) as! UILabel
        let textLabel = cell.viewWithTag(2) as! UILabel
       let note = fetchedNoteRC?.object(at: indexPath)
        if let note = note{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
            dateLabel.text = dateFormatter.string(from: note.date!)
            textLabel.text = note.text
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       let delteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
           if self.fetchedNoteRC == nil {
               return
           }
            let n = self.fetchedNoteRC!.object(at: indexPath)
           self.context.delete(n)
           do{
                self.appDelegate.saveContext()
               self.refresh()
           }catch{
               print(error.localizedDescription)
           }
        }
        return UISwipeActionsConfiguration(actions: [delteAction])
    }
    
}
