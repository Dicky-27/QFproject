//
//  PaddingLabel.swift
//  QFproject
//
//  Created by Dicky Buwono on 20/06/21.
//

import Foundation
import UIKit

@IBDesignable public class PaddingLabel: UILabel {
    
    //MARK : ADD CUSTOM ARTRIBUTE ISPECTOR LABEL
    
    @IBInspectable var topInsert: CGFloat = 0
    @IBInspectable var bottomInsert: CGFloat = 0
    @IBInspectable var leftInsert: CGFloat = 0
    @IBInspectable var rightInsert: CGFloat = 0
    
    public override func drawText(in rect: CGRect) {
        let inserts = UIEdgeInsets.init(top: topInsert, left: leftInsert, bottom: bottomInsert, right: rightInsert)
        
        super.drawText(in: rect.inset(by: inserts))
    }
    
    
    public override var intrinsicContentSize: CGSize{
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInsert + rightInsert, height: size.height + topInsert + bottomInsert)
    }
    
    @IBInspectable var borderColor: UIColor = UIColor(named: "ButtonColor") ?? UIColor.white {
            didSet {
                layer.borderColor = borderColor.cgColor
            }
        }

        @IBInspectable var borderWidth: CGFloat = 1.0 {
            didSet {
                layer.borderWidth = borderWidth
            }
        }

        @IBInspectable var cornerRadius: CGFloat = 5.0 {
            didSet {
                layer.cornerRadius = cornerRadius
            }
        }

}
