//
//  KeyboardViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 14/06/21.
//

import UIKit

class KeyboardViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var cobain2: UITextView!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var active: UITextField!
    
    var cek = true
    var aktif: UITextView!
    var vc = ""
    
    let center: NotificationCenter = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cobain2.delegate = self
        
        cobain2.layer.cornerRadius = 12
        
        
        
        center.addObserver(self, selector: #selector(keyboardShown(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardShown(notification: )), name: UIResponder.keyboardWillHideNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardShown(notification: )), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        center.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        center.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        center.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc func keyboardShown(notification: Notification) {
//        
//        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//            return
//        }
        
        
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -200
        } else {
            view.frame.origin.y = 0
        }

        
    }
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func hideKeyboard() {
        cobain2.resignFirstResponder()
        
    }
    


    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
      
       performSegue(withIdentifier: "savingSegue", sender: self)
        
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "savingSegue" {
            if let nexVC = segue.destination as? PersonViewController {
                nexVC.significantMoment = cobain2.text
            }
        }
    }
    
    func saveItems() {
        do {
          try context.save()
        } catch {
           print("Error saving context \(error)")
        }
    }
}


