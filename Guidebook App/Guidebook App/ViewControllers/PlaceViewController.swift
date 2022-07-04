//
//  PlaceViewController.swift
//  Guidebook App
//
//  Created by Burak AKCAN on 1.07.2022.
//

import UIKit

class PlaceViewController: UIViewController {
    // MARK: -Variables and properties
    var place:Place?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    lazy var infoViewController : InfoViewController = {
        let infoVC = storyboard?.instantiateViewController(withIdentifier: Constants.INFO_VIEWCONTROLLER) as! InfoViewController
        return infoVC
    }()
    
    lazy var mapViewController:MapViewController = {
        let mapVC = storyboard?.instantiateViewController(withIdentifier: Constants.MAP_VIEWCONTROLLER) as! MapViewController
        return mapVC
    }()
    
    lazy var noteViewController:NotesViewController = {
        let noteVC = storyboard?.instantiateViewController(withIdentifier: Constants.NOTE_VIEWCONTROLLER) as! NotesViewController
        return noteVC
    }()
    
    
    //MARK: -LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Set image ,set name
        if let placeImage = place?.imageName,
           let placeName = place?.name{
            imageView.image = UIImage(named: placeImage)
            placeNameLabel.text = placeName
            
            
            switchChildVC(mapViewController)
            segmentChange(self.segmentControl)
            
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
   
    
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            switchChildVC(infoViewController)
            infoViewController.place = self.place
        case 1:
            switchChildVC(mapViewController)
            mapViewController.place = self.place
        case 2:
            switchChildVC(noteViewController)
            noteViewController.place = self.place
        default:
            switchChildVC(infoViewController)
        }
    }
    
    
    
    //MARK: -Methods
    
  private func switchChildVC(_ childVC:UIViewController){
        
       
        
        //add it as child view controller of this one
        addChild(childVC)
        
        //add its view as subview of the container view
        containerView.addSubview(childVC.view)
        
        //set frame and size
        childVC.view.frame = containerView.bounds
        childVC.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        //child ın taşındığını bildirir
        childVC.didMove(toParent: self)
        
    }
}
