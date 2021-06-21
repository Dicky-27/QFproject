//
//  NewStoryViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 06/06/21.
//

import UIKit
import CoreData




class NewStoryViewController: UIViewController {

   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var isDismissed: (() -> Void)?
    
    var stories = [Stories]()
    
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    @IBOutlet weak var titleLbl: UITextField!
    @IBOutlet weak var premis1: UITextField!
    @IBOutlet weak var beforeWants: UITextField!
    @IBOutlet weak var afterWants: UITextField!
    @IBOutlet weak var afterBut: UITextField!
    @IBOutlet weak var templateView: UIView!
    
    @IBOutlet weak var switchButton: UISwitch!
    
    @IBOutlet weak var barButton: UIBarButtonItem!
    
    
    // MARK : Use closure
    
    let center: NotificationCenter = NotificationCenter.default
    
    var wants = ""
    var needs = ""
    var goals = ""
    
    var onCreate: (() -> Void)?
    
    var activeTextField : UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        apperence()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewStoryViewController.backgroundTap))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewStoryViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
          
        NotificationCenter.default.addObserver(self, selector: #selector(NewStoryViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        titleLbl.delegate = self
        premis1.delegate = self
        beforeWants.delegate = self
        afterWants.delegate = self
        afterBut.delegate = self
        
     
 
        
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
            
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

          var shouldMoveViewUp = false

          // if active text field is not nil
          if let activeTextField = activeTextField {

            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            
            let topOfKeyboard = self.view.frame.height - keyboardSize.height

            // if the bottom of Textfield is below the top of keyboard, move up
            if bottomOfTextField > topOfKeyboard {
              shouldMoveViewUp = true
            }
          }

          if(shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - 130
          }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
    
    @objc func backgroundTap(_ sender: UITapGestureRecognizer) {
        // go through all of the textfield inside the view, and end editing thus resigning first responder
        // ie. it will trigger a keyboardWillHide notification
        self.view.endEditing(true)
    }
    
    
    

    
    @objc func addTapped() {
        let newStory = Stories(context: self.context)
        newStory.title = titleLbl.text

        
        
        if switchButton.isOn == true {
            wants = beforeWants.text ?? ""
            needs = afterWants.text ?? ""
            goals = afterBut.text ?? ""
            
            newStory.premis = "\(wants) wants \(needs) but \(goals)"
        }else {
            newStory.premis = premis1.text
        }
        
        
            self.stories.append(newStory)
            self.saveStories()
        
        self.isDismissed?()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func saveStories() {
        
        // MARK : - Typecasting
        
//        guard
//            let splitVC = presentingViewController as? SplitViewContoller,
//            let navVC = splitVC.viewControllers.first as? UINavigationController,
//            let storyVC = navVC.viewControllers.first as? StoryTableViewController
//        else {
//            return
//
//        }
        
        do {
            try context.save()
            if let unwrapOncreate = onCreate{
                unwrapOncreate()
            }
        } catch {
            print("Error saving category \(error)")
        }
        
        
        
    }
    
    @IBAction func templateButton(_ sender: UISwitch) {
        let switchStatus:Bool = sender.isOn
        
        if(switchStatus == true){
            premis1.isHidden = true
            templateView.isHidden = false
    
        }else{
            premis1.isHidden = false
            templateView.isHidden = true
        }
    }
        
    
    
    func apperence(){
        premis1.isHidden = false
        templateView.isHidden = true
        switchButton.isOn = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(addTapped))
        
        let button1 = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem  = button1
        
        
        
        
        navigationController?.navigationBar.tintColor = UIColor(named: "ButtonColor")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "TitleColor") ?? ""]
        
        titleLbl.layer.masksToBounds = true
        titleLbl.layer.borderWidth = 0.5
        titleLbl.layer.cornerRadius = 7
        titleLbl.layer.borderColor = UIColor(named: "TextFieldColor")?.cgColor
        
        premis1.layer.cornerRadius = 12
        premis1.layer.masksToBounds = true
        premis1.layer.borderWidth = 0.5
        premis1.layer.cornerRadius = 7
        premis1.layer.borderColor = UIColor(named: "TextFieldColor")?.cgColor
        
        beforeWants.layer.cornerRadius = 12
        beforeWants.layer.masksToBounds = true
        beforeWants.layer.borderWidth = 0.5
        beforeWants.layer.cornerRadius = 7
        beforeWants.layer.borderColor = UIColor(named: "TextFieldColor")?.cgColor
        
        afterWants.layer.cornerRadius = 12
        afterWants.layer.masksToBounds = true
        afterWants.layer.borderWidth = 0.5
        afterWants.layer.cornerRadius = 7
        afterWants.layer.borderColor = UIColor(named: "TextFieldColor")?.cgColor
        
        afterBut.layer.cornerRadius = 12
        afterBut.layer.masksToBounds = true
        afterBut.layer.borderWidth = 0.5
        afterBut.layer.cornerRadius = 7
        afterBut.layer.borderColor = UIColor(named: "TextFieldColor")?.cgColor
        
        templateView.layer.cornerRadius = 7
        
        
    }
    
    func hideKeyboard() {
        
    }
}

extension NewStoryViewController : UITextFieldDelegate {
  // when user select a textfield, this method will be called
  func textFieldDidBeginEditing(_ textField: UITextField) {
    // set the activeTextField to the selected textfield
    self.activeTextField = textField
  }
    
  // when user click 'done' or dismiss the keyboard
  func textFieldDidEndEditing(_ textField: UITextField) {
    self.activeTextField = nil
  }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

}

