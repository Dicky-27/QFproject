//
//  InfoTableViewCell.swift
//  QFproject
//
//  Created by Dicky Buwono on 19/06/21.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var judulItem: UILabel!
    @IBOutlet weak var descItem: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
