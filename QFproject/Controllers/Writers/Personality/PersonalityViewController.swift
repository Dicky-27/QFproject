//
//  PersonalityViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 15/06/21.
//

import UIKit

class PersonalityViewController: UIViewController {

    @IBOutlet weak var questButton: UIButton!
    @IBOutlet weak var pil1: UIButton!
    @IBOutlet weak var pil2: UIButton!
    @IBOutlet weak var pil3: UIButton!
    
    var hasil = 0
    var vc = ""
    @IBOutlet weak var kotak: UIView!
    
    @IBOutlet weak var line: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        questButton.setBackgroundImage(UIImage(named: "questionPer"), for: .normal)
        pil1.setBackgroundImage(UIImage(named: "chat"), for: .normal)
        pil2.setBackgroundImage(UIImage(named: "chat"), for: .normal)
        pil3.setBackgroundImage(UIImage(named: "chat"), for: .normal)
        
        line.layer.borderWidth = 1
        kotak.layer.borderWidth = 1
        kotak.layer.cornerRadius = 12
    }
    
    

    

    @IBAction func jawab(_ sender: UIButton) {
        
        if sender.tag == 0 {
    
            if pil1.isSelected {
                pil1.isSelected = false
                pil2.isSelected = false
                pil3.isSelected = false
                
                
                pil1.setBackgroundImage(UIImage(named: "chat"), for: .normal)
                pil2.setBackgroundImage(UIImage(named: "chat"), for: .normal)
                pil3.setBackgroundImage(UIImage(named: "chat"), for: .normal)
                
                hasil = 0
                
            }else {
                pil1.isSelected = true
                pil2.isSelected = false
                pil3.isSelected = false
                
                
                pil1.setBackgroundImage(UIImage(named: "selectedChat"), for: .normal)
                pil2.setBackgroundImage(UIImage(named: "chat"), for: .normal)
                pil3.setBackgroundImage(UIImage(named: "chat"), for: .normal)
                
                hasil = 1
            }
            
        }else if sender.tag == 1 {
            
            if pil2.isSelected {
                pil1.isSelected = false
                pil2.isSelected = false
                pil3.isSelected = false
                
                
                pil1.setBackgroundImage(UIImage(named: "chat"), for: .normal)
                pil2.setBackgroundImage(UIImage(named: "chat"), for: .normal)
                pil3.setBackgroundImage(UIImage(named: "chat"), for: .normal)
                
                hasil = 0
                
            }else {
                pil2.isSelected = true
                pil1.isSelected = false
                pil3.isSelected = false
                
                
                pil2.setBackgroundImage(UIImage(named: "selectedChat"), for: .normal)
                pil1.setBackgroundImage(UIImage(named: "chat"), for: .normal)
                pil3.setBackgroundImage(UIImage(named: "chat"), for: .normal)
                
                hasil = 2
            }
            
        }else {
            if pil3.isSelected {
                pil1.isSelected = false
                pil2.isSelected = false
                pil3.isSelected = false
                
                
                pil1.setBackgroundImage(UIImage(named: "chat"), for: .normal)
                pil2.setBackgroundImage(UIImage(named: "chat"), for: .normal)
                pil3.setBackgroundImage(UIImage(named: "chat"), for: .normal)
                
                hasil = 0
                
            }else {
                pil3.isSelected = true
                pil1.isSelected = false
                pil2.isSelected = false
                
                
                pil3.setBackgroundImage(UIImage(named: "selectedChat"), for: .normal)
                pil1.setBackgroundImage(UIImage(named: "chat"), for: .normal)
                pil2.setBackgroundImage(UIImage(named: "chat"), for: .normal)
                
                hasil = 3
            }
            
        }
        
        
    }
    @IBAction func nextButton(_ sender: UIBarButtonItem) {
        
       performSegue(withIdentifier: "goSave", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goSave" {
            if let nextVC = segue.destination as? ResultViewController {
                nextVC.check = hasil
                
            }
        }
    }
    
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func unwindToPersonality (_ sender: UIStoryboardSegue) {
        
    }

}
