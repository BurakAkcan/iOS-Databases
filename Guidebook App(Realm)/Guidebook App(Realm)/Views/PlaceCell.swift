//
//  PlaceCell.swift
//  Guidebook App(Realm)
//
//  Created by Burak AKCAN on 8.07.2022.
//

import UIKit

class PlaceCell: UITableViewCell {
    var place:Place?

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func showPlace(_ p:Place){
        place = p
        nameLabel.text = p.name
    }

}
