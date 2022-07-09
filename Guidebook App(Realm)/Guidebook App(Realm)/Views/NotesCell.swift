//
//  NotesCell.swift
//  Guidebook App(Realm)
//
//  Created by Burak AKCAN on 8.07.2022.
//

import UIKit

class NotesCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    func showNote(_ note:Note){
        dateLabel.text = note.date
        noteLabel.text = note.text
    }

}
