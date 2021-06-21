//
//  ResultViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 15/06/21.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var hasil: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var gambar: UIImageView!
    
    
    var check = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        if check == 1 {
            gambar.image = #imageLiteral(resourceName: "Extrovert")
            hasil.text = "Extrovert"
            desc.text = "Enjoy social settings . Outgoing and optimistic . Flexible . Likes to talk things out"
        }else if check == 2 {
            gambar.image = #imageLiteral(resourceName: "Ambivert")
            hasil.text = "Ambivert"
            desc.text = "Good listener and communicator . Provide balance in group settings . Comfortable in social settings . Value alone time"
        }else {
            gambar.image = #imageLiteral(resourceName: "Introvert")
            hasil.text = "Introvert"
            desc.text = "Your character’s an introvert! Have a close circle of friends . Introspective . Curious . Enjoy spend time alone"
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
            
                
                CharLandingViewController.selectedChars?.setValue(self.hasil.text, forKey: "personality")
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
            
                
                CharLandingViewController.itemArray.last?.setValue(self.hasil.text, forKey: "personality")
                self.saveItems()
                self.dismiss(animated: true, completion: {
                    vc.alernya()
                })
            
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
       
        
    }
    
    
    @IBAction func retakeQuiz(_ sender: UIButton) {
        
        
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
