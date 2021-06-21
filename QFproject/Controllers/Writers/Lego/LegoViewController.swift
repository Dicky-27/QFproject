//
//  LegoViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 18/06/21.
//

import UIKit

class LegoViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var tView: UITextView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var vc = ""
    
    let center: NotificationCenter = NotificationCenter.default
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tView.layer.cornerRadius = 12
        
        image.image = UIImage(named: "Hobbies")
        desc.text = "Your character’s routine usually came up during the beginning of your movie before the inciting incident. Try to be as detailed as possible."
        question.text = "What does your character's daily life look like?"
        
        center.addObserver(self, selector: #selector(keyboardShown(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardShown(notification: )), name: UIResponder.keyboardWillHideNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardShown(notification: )), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        center.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        center.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        center.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func hideKeyboard() {
        tView.resignFirstResponder()
        
    }

    @objc func keyboardShown(notification: Notification) {
        
//        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//            return
//        }
        
        
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -200
        } else {
            view.frame.origin.y = 0
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
                
                CharLandingViewController.selectedChars?.setValue(self.tView.text, forKey: "hobby")
            
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
                
               
                CharLandingViewController.itemArray.last?.setValue(self.tView.text, forKey: "hobby")
            
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
    
    
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
