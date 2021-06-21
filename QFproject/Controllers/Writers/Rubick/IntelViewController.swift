//
//  IntelViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 17/06/21.
//

import UIKit

class IntelViewController: UIViewController {

    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var imagenya: UIImageView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    var cek = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        if cek == 0 {
            result.text = "Defeatist"
            desc.text = "I’ll never be able to do that. I’m just not that talented. \nGives up easily . Afraid to take action & failing . Tend to feel sorry for themselves"
            imagenya.image = UIImage(named: "Defeatist")
            
        }else if cek == 1 {
            result.text = "Critic"
            desc.text = "Told you that would get screwed up. It’s all your fault. \nNot afraid to speak up . Blame someone when something goes wrong . Likes to point out mistakes"
            imagenya.image = UIImage(named: "Critic")
        }else if cek == 2 {
            result.text = "Dreamer"
            desc.text = "I’m an idea person. Don’t bother me with the nitty gritty details. \nLoves to come up with new ideas . Rarely get things done . Has many dreams"
            imagenya.image = UIImage(named: "Dreamer")
        }else if cek == 3 {
            result.text = "Go-Getter"
            desc.text = "I’ve got to try harder! I can’t stop now! \nNot worry about problems . Quickly jump into action . Rarely stop to reflect"
            imagenya.image = UIImage(named: "Go Getter")
        }else if cek == 4 {
            result.text = "Problem Solver"
            desc.text = "To fix this, we’re going to need to do X, Y, and Z. Let’s try them. \nSet specific goals . Have positive attitudes . Come up with action plan"
            imagenya.image = UIImage(named: "Problem Solver")
        } else {
            
            let alert = UIAlertController(title: "", message: "Your character seems to have opposing problem solving styles. Try to reconsider your answers.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Retake", style: .default) { (action) in
            
                
                self.performSegue(withIdentifier: "ulang", sender: self)
            
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    

  
    @IBAction func retakeButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "ulang", sender: self)
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
                CharLandingViewController.selectedChars?.setValue(self.result.text, forKey: "perspective")
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
                CharLandingViewController.itemArray.last?.setValue(self.result.text, forKey: "perspective")
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
