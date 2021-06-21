//
//  PiggyViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 15/06/21.
//

import UIKit

class PiggyViewController: UIViewController {

    @IBOutlet weak var low: CornerButton!
    @IBOutlet weak var middle: CornerButton!
    @IBOutlet weak var high: CornerButton!
    
    var status = 0
    var vc = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func answerButton(_ sender: UIButton) {
        
        if sender.tag == 0 {
    
            if low.isSelected {
                low.isSelected = false
                middle.isSelected = false
                high.isSelected = false
                
                
                low.backgroundColor = UIColor.white
                middle.backgroundColor = UIColor.white
                high.backgroundColor = UIColor.white
                
                status = 0
                
            }else {
                low.isSelected = true
                middle.isSelected = false
                high.isSelected = false
                
                
                low.backgroundColor = UIColor(named: "ButtonColor")
                middle.backgroundColor = UIColor.white
                high.backgroundColor = UIColor.white
                
                status = 1
            }
            
        }else if sender.tag == 1 {
            
            if middle.isSelected {
                low.isSelected = false
                middle.isSelected = false
                high.isSelected = false
                
                
                low.backgroundColor = UIColor.white
                middle.backgroundColor = UIColor.white
                high.backgroundColor = UIColor.white
                
                status = 0
                    
            }else {
                middle.isSelected = true
                low.isSelected = false
                high.isSelected = false
                
                
                middle.backgroundColor = UIColor(named: "ButtonColor")
                low.backgroundColor = UIColor.white
                high.backgroundColor = UIColor.white
                
                status = 2
            }
            
        }else {
            if high.isSelected {
                low.isSelected = false
                middle.isSelected = false
                high.isSelected = false
                
                
                low.backgroundColor = UIColor.white
                middle.backgroundColor = UIColor.white
                high.backgroundColor = UIColor.white
                
                status = 0
                    
            }else {
                high.isSelected = true
                middle.isSelected = false
                low.isSelected = false
                
                
                high.backgroundColor = UIColor(named: "ButtonColor")
                low.backgroundColor = UIColor.white
                middle.backgroundColor = UIColor.white
                
                status = 3
            }
            
        }
    }
    
    @IBAction func nextButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goPiggy", sender: self)
        
    }
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goPiggy" {
            if let nextVC = segue.destination as? CommunityViewController {
                nextVC.cekSegue = false
                nextVC.cekEco = status
                
            }
        }
    }
    @IBAction func unwindToGlass(_ sender: UIStoryboardSegue){
        
    }
}
