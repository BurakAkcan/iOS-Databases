//
//  InfoViewController.swift
//  Guidebook App
//
//  Created by Burak AKCAN on 1.07.2022.
//

import UIKit

class InfoViewController: UIViewController {
    //MARK: - Variables and Propeties
    var place:Place?

    @IBOutlet weak var summaryLabel: UILabel!
    
    //MARK: -ViewController lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        summaryLabel.text = place?.summary
    }
    

    
}
