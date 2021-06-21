//
//  EconomicViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 14/06/21.
//

import UIKit

class CommunityViewController: UIViewController {

    var check = 1
    
    var cekEco = 3
    
    var cekSegue = true
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var result: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var retake: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        retake.layer.cornerRadius = 12
        
        // Do any additional setup after loading the view.
        
        if cekSegue == true {
            if check == 1 {
                result.text = "Pessimist"
                itemImage.image = #imageLiteral(resourceName: "Pessimist")
            }else if check == 2 {
                result.text = "Optimist"
                itemImage.image = #imageLiteral(resourceName: "Optimist")
            }else {
                result.text = "Realist"
                itemImage.image = #imageLiteral(resourceName: "Realist")
            }
        }else {
            if cekEco == 1 {
                result.text = "Low"
                itemImage.image = #imageLiteral(resourceName: "Low Class")
            }else if cekEco == 2 {
                result.text = "Middle"
                itemImage.image = #imageLiteral(resourceName: "Middle Class")
            }else {
                result.text = "High"
                itemImage.image = #imageLiteral(resourceName: "High Class")
            }
        }
        
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func retakeButton(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "unwindToGlassSegueId", sender: self)
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        guard
            let vc = presentingViewController as? WritersRoomViewController
        else {
            return
        }
        
        if CharLandingViewController.newItem == false {
            
            if cekSegue == true {
                
                let alert = UIAlertController(title: "Character Saved", message: "Your changes have been saved", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .default) { (action) in
                
                    
                    // untuk important value
                    CharLandingViewController.selectedChars?.setValue(self.result.text, forKey: "community")
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
                    CharLandingViewController.selectedChars?.setValue(self.result.text, forKey: "economiClass")
                    self.saveItems()
                
                    self.dismiss(animated: true, completion: {
                        vc.alernya()
                    })
                }
                
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        }else {
            if cekSegue == true {
                
                let alert = UIAlertController(title: "Character Saved", message: "Your changes have been saved", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .default) { (action) in
                
                    
                    // untuk important value
                    CharLandingViewController.itemArray.last?.setValue(self.result.text, forKey: "community")
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
                    CharLandingViewController.itemArray.last?.setValue(self.result.text, forKey: "economiClass")
                    self.saveItems()
                
                    self.dismiss(animated: true, completion: {
                        vc.alernya()
                    })
                }
                
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
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
