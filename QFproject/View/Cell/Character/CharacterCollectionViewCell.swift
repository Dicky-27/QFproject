//
//  CharacterCollectionViewCell.swift
//  Todoey
//
//  Created by Dicky Buwono on 05/06/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit


protocol CharCellDelegate: AnyObject {
    func delete(cell: CharacterCollectionViewCell)
}


class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var CcImage: UIImageView!
    @IBOutlet weak var ccLbl: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var deleteBackgroundView: UIVisualEffectView!
    
    weak var delegate: CharCellDelegate?
    
    
    var imageNamed: UIImage! {
        didSet {
            CcImage.image = imageNamed
            deleteBackgroundView.layer.cornerRadius = deleteBackgroundView.bounds.width / 2.0
            
            deleteBackgroundView.layer.masksToBounds = true
            deleteBackgroundView.isHidden = !isEditing
            
            
            
        }
    }
    
    var isEditing: Bool =  false {
        didSet {
            deleteBackgroundView.isHidden = !isEditing
            
        }
    }
    

    @IBAction func deleteButtonDidtap(_ sender: Any) {
        
        delegate?.delete(cell: self)
    }
    
    
   
    
}
