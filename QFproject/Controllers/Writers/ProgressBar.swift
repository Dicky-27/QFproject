//
//  ProgressBar.swift
//  QFproject
//
//  Created by Dicky Buwono on 17/06/21.
//

import Foundation
import UIKit

@IBDesignable
class ProgressBar: UIView {
    
    @IBInspectable var color: UIColor = .gray {
        didSet { setNeedsDisplay() }
    }

    var holder: CGFloat = 0
    let square = CAShapeLayer()
    let square2 = CAShapeLayer()
    let square3 = CAShapeLayer()
    let square4 = CAShapeLayer()
    var imageView = UIImageView()
    
    var progress: CGFloat = 0 {
        didSet { setNeedsDisplay() }
    }

    private let progressLayer = CALayer()
    private let backgroundMask = CAShapeLayer()
    //private let aPath = CGMutablePath()
    var imageNamed = ""
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }

    private func setupLayers() {
        layer.addSublayer(progressLayer)
        self.layer.addSublayer(square2)
        self.layer.addSublayer(square)
        self.layer.addSublayer(square3)
        
        self.addSubview(imageView)

        
    }

    override func draw(_ rect: CGRect) {
         
        let aPath: CGMutablePath = CGMutablePath()
        let aPath2: CGMutablePath = CGMutablePath()
        let aPath3: CGMutablePath = CGMutablePath()
        let aPath4: CGMutablePath = CGMutablePath()
    
        if progress >= holder {
            let image = UIImage(named: "1")
            imageView.image = image
        }else{
            let image = UIImage(named: "2")
            imageView.image = image
        }
       
        
        
        imageView.frame = CGRect(x: (rect.width * progress) - 125, y: 30, width: 250, height: 50)
        
        aPath4.addRoundedRect(in: CGRect(x: 0, y: 20, width: rect.width, height: 40), cornerWidth: 10, cornerHeight: 10)
        
        
        aPath2.addEllipse(in: CGRect(x: rect.width - 7, y: -10, width:45, height: 45))
        aPath2.addEllipse(in: CGRect(x: -35, y: -10, width:45, height: 45))
        
        aPath3.addRoundedRect(in: CGRect(x: rect.width * holder, y: -7, width: 20, height: 40), cornerWidth: 10, cornerHeight: 10)
        
        aPath.addEllipse(in: CGRect(x: rect.width + 6, y: 2, width: 20, height: 20))
        aPath.addEllipse(in: CGRect(x: -23, y: 2, width: 20, height: 20))
        //aPath.addRoundedRect(in: CGRect(x: rect.width/2, y: -5, width: 20, height: 40), cornerWidth: 10, cornerHeight: 10)
        aPath.closeSubpath()

        let other: CGPath = aPath.copy(strokingWithWidth: 12, lineCap: .round, lineJoin: .round, miterLimit: 20.0)
        
        
        square2.fillColor = UIColor(named: "warna")?.cgColor
        square2.path = aPath2
        
        
        square3.path = aPath3
        square3.fillColor = UIColor(named: "pl")?.cgColor
        
        
        
        
        square.fillColor = UIColor(named: "pl")?.cgColor
        square.path = other
        
        
        square4.path = aPath4
        

        backgroundMask.path = aPath
        
    
        layer.mask = backgroundMask
        backgroundMask.fillColor = UIColor(named: "warna")?.cgColor
        self.layer.addSublayer(backgroundMask)

        
        

       // let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height/2))
        let progressRect = CGRect(x:0 , y: rect.height/4, width: rect.width * progress, height: rect.height/2)
    
        
        progressLayer.frame = progressRect
        progressLayer.cornerRadius = 5
        
        progressLayer.backgroundColor = UIColor(named: "pl")?.cgColor
        progressLayer.layoutSublayers()
        
    }
}

