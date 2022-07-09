//
//  DetailViewController.swift
//  Guidebook App(Realm)
//
//  Created by Burak AKCAN on 7.07.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    var place:Place?

    override func viewDidLoad() {
        super.viewDidLoad()
        //Check place
        if place != nil {
            showPlace(place!)
        }

    }
    
    func showPlace(_ p:Place){
        nameLabel.text = p.name
        addressLabel.text = p.address
        summaryLabel.text = p.summary
    }
    @IBAction func backTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func notesTapped(_ sender: UIButton) {
        let notesVC = storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.notesViewController) as? NotesViewController
        if let notesVC = notesVC {
            //set place property
            notesVC.place = place
            //present view controller
            present(notesVC, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func mapTapped(_ sender: UIButton) {
        let mapVC = storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.mapViewController) as? MapViewController
        if let mapVC = mapVC {
            mapVC.place = place
            present(mapVC, animated: true, completion: nil)
        }
    }
    
}
