//
//  SmartViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 14/06/21.
//

import UIKit

class SmartViewController: UIViewController {

    
    var checkSmart: Bool = true

    @IBOutlet weak var Intellegence: UILabel!
    @IBOutlet weak var smartImage: UIImageView!
    @IBOutlet weak var desc: UILabel!
    var smart = ""
    
    @IBOutlet weak var reButton: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        reButton.layer.cornerRadius = 12
        

        // Do any additional setup after loading the view.
        
        if checkSmart == true {
            Intellegence.text = "Book Smart"
            desc.text = "Follow the rules . Love structures . Enjoy learning"
            smartImage.image = UIImage(named: "pertama")
            smart = "Book Smart"
        
        }else {
            Intellegence.text = "Street Smart"
            desc.text = "Follow the rules . Love structures . Enjoy learning"
            smartImage.image = UIImage(named: "kedua")
            smart = "Street Smart"
        }
        
        
    }
    


    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        
        guard
            let vc = presentingViewController as? WritersRoomViewController
        else {
            return
        }
    
        if CharLandingViewController.newItem == false {
            
            let alert = UIAlertController(title: "Character Saved", message: "Your changes have been saved", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            
                
                // untuk important value
                CharLandingViewController.selectedChars?.setValue(self.smart, forKey: "intelligence")
                self.saveItems()
                self.dismiss(animated: true, completion: {
                    vc.alernya()
                })
            
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }else {
            
            let alert = UIAlertController(title: "Character Saved", message: "Your changes have been saved", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            
                
                // untuk important value
                CharLandingViewController.itemArray.last?.setValue(self.smart, forKey: "intelligence")
                self.saveItems()
                self.dismiss(animated: true, completion: {
                    vc.alernya()
                })
            
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    
        
        
    }
    
    func saveItems() {
        do {
          try context.save()
            guard
                let vc = presentingViewController as? WritersRoomViewController
            else {
                return
            }
            
            if CharLandingViewController.newItem == false {
                vc.progress = 0
                vc.horizontalBar.progress = 0
                vc.hitungProgress(item: false)
                vc.horizontalBar.progress = vc.progress
            }else {
                vc.progress = 0
                vc.horizontalBar.progress = 0
                vc.hitungProgress(item: true)
                vc.horizontalBar.progress = vc.progress
            }
        } catch {
           print("Error saving context \(error)")
        }
    }

   
    
}
