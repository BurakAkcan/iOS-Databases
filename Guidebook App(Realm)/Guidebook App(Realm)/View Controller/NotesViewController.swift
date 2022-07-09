//
//  NotesViewController.swift
//  Guidebook App(Realm)
//
//  Created by Burak AKCAN on 7.07.2022.
//

import UIKit
import RealmSwift

class NotesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var place:Place?
    var notes:Results<Note>?

    @IBOutlet weak var noteTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTableView.delegate = self
        noteTableView.dataSource = self
        
        
        //Get notes for the place
        if place != nil {
            notes = NoteService.getNotes(place!.placeId!, updates: {
                //result has updated , reload notetableview
                self.noteTableView.reloadData()
            })
        }

    }
    
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        //Dismiss the view controller
        
        dismiss(animated: true)
    }
    
    @IBAction func composeTapped(_ sender: UIBarButtonItem) {
        //cretae a new compose
        let composeVC = storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.composoViewController) as? ComposeViewController
        if let composeVC = composeVC {
            //Set the place property
            composeVC.place = place
            //set the pressentation mode
            composeVC.modalPresentationStyle = .fullScreen
            //present it
            present(composeVC, animated: false, completion: nil)
        }
    }
    

}
extension NotesViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes == nil ? 0 : notes!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NotesCell
        
        if let notes = notes {
            let n = notes[indexPath.row]
            cell.showNote(n)
            return cell
            
        }else{
            return UITableViewCell()
        }
    }
}
