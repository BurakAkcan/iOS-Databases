//
//  ComposeViewController.swift
//  Guidebook App(Realm)
//
//  Created by Burak AKCAN on 7.07.2022.
//

import UIKit

class ComposeViewController: UIViewController {
    var place:Place?
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var doneButton:UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.layer.cornerRadius = 10
        doneButton.layer.cornerRadius = 10
        cancelButton.layer.borderColor = UIColor.lightGray.cgColor
        cancelButton.layer.borderWidth = 2
        doneButton.layer.borderColor = UIColor.lightGray.cgColor
        doneButton.layer.borderWidth = 2
        doneButton.layer.shadowColor = UIColor.red.cgColor
        doneButton.layer.shadowOpacity = 0.4
        doneButton.layer.shadowOffset = CGSize(width: 1, height: -3)
        cancelButton.layer.shadowColor = UIColor.red.cgColor
        cancelButton.layer.shadowOpacity = 0.4
        cancelButton.layer.shadowOffset = CGSize(width: 1, height: -3)
        

    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        print(place!.placeId!)
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        guard place != nil else{return}
        //create note
        let note = Note()
        note.text = textView?.text ?? "test"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        note.date = dateFormatter.string(from: Date())
        note.placeId = place!.placeId!
        //Save note
        NoteService.addNote(note)
        dismiss(animated: true, completion: nil)
       

   }
    
}
