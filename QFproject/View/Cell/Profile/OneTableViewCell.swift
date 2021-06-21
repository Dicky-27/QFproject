//
//  OneTableViewCell.swift
//  QFproject
//
//  Created by Dicky Buwono on 10/06/21.
//

import UIKit

class OneTableViewCell: UITableViewCell {

    @IBOutlet weak var kontenLbl: UILabel!
    @IBOutlet weak var kontenTf: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
