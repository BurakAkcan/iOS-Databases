//
//  PlaceTableViewCell.swift
//  Guidebook App
//
//  Created by Burak AKCAN on 3.07.2022.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var placeImageView: UIImageView!
    
    @IBOutlet weak var placeNameLabel: UILabel!
    
    // MARK: - LifeCyle
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        //Style cell background
        cardView.layer.cornerRadius = 20
        shadowView.layer.cornerRadius = 20
        shadowView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.8)
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Methods
    func setCell(_ p:Place){
        if p.imageName != nil {
            self.placeImageView.image = UIImage(named: p.imageName!)
        }else{
            self.placeImageView.image = UIImage.add
        }
        
        self.placeNameLabel.text = p.name
    }

}
