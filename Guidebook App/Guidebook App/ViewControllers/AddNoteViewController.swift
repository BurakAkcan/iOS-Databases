//
//  AddNoteViewController.swift
//  Guidebook App
//
//  Created by Burak AKCAN on 4.07.2022.
//

import UIKit
import CoreData

protocol AddNoteDelegatee{
    func noteAdded()
}

class AddNoteViewController: UIViewController {
    //MARK: - Variables
    
    var delegate:AddNoteDelegatee?
    var place:Place?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var textView: UITextView!
    //MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 20
       // view.backgroundColor = UIColor.def

    }
    override func viewWillAppear(_ animated: Bool) {
       // print(place?.summary)
    }
    
    //MARK: -Methods
    //Bu methot note ekle sayfası çıktıktn sonra ekranda herhangi bir yere dokundğunda sayfayı kapatır
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    

    @IBAction func saveTapped(_ sender: UIButton) {
        //create new not
        if let place = place {
            let note = Note(context: context)
            note.date = Date()
            note.text = textView.text
            place.addToNotes(note)
            //Save coreData
            appDelegate.saveContext()
            delegate?.noteAdded()
            dismiss(animated: true)
            
            
        }else{return}
        
        
       
    }
}
