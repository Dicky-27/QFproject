//
//  StoryTableViewCell.swift
//  QFproject
//
//  Created by Dicky Buwono on 07/06/21.
//

import UIKit

class StoryTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        if selected {
            contentView.backgroundColor = UIColor(named: "ButtonColor")
            contentView.layer.borderWidth = 2.0
            contentView.layer.borderColor = UIColor(named: "ButtonColor")?.cgColor
            titleLbl.textColor = .white
            
            
            
        }else {
           
            contentView.backgroundColor = .white
            contentView.layer.borderWidth = 2.0
            contentView.layer.borderColor = UIColor(named: "ButtonColor")?.cgColor
            titleLbl.textColor = UIColor(named: "ButtonColor")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        contentView.layer.cornerRadius = 10
        
    }

}
