//
//  LeListViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 17/06/21.
//

import UIKit

class LeListViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var texViewnya: UITextView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var cek = true
    var vc = ""
    var cobain = ""
    
    let center: NotificationCenter = NotificationCenter.default
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        texViewnya.layer.cornerRadius = 12
        
        image.image = UIImage(named: "Routine")
        desc.text = "Giving your character hobbies gives the audience insights to the type of person your character is. Think of hobbies that reflect their personality traits, affect the plot, or make them behave the way they do."
        question.text = "What does your character like to do during their spare time?"
        
        
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
        texViewnya.resignFirstResponder()
        
    }

    
    @objc func sButton() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
                    
                    CharLandingViewController.selectedChars?.setValue(self.texViewnya.text, forKey: "routines")
                
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
                    
                    CharLandingViewController.itemArray.last?.setValue(self.texViewnya.text, forKey: "routines")
                
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
    
    
    @objc func keyboardShown(notification: Notification) {
           
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -200
        } else {
            view.frame.origin.y = 0
        }

        
    }
}
