//
//  CoreViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 08/06/21.
//

import UIKit
import CoreData

class CoreViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
    private let spacing:CGFloat = 5
    @IBOutlet weak var premisLbl: UILabel!
    @IBOutlet weak var wantsTf: UITextField!
    @IBOutlet weak var needsTf: UITextField!
    @IBOutlet weak var goalsTf: UITextField!
    @IBOutlet weak var obsTf: UITextField!
    
    var name = ""
    var important = ""
    
    var wants = ""
    var needs = ""
    var goals = ""
    var obs = ""
    
    var vc = ""
    
  //  var indexnya = 0
    
    
    var check2: Bool = true
    
  //  var selectedParentStories: Stories?
  
    var itemArray = [Characters]()
    
    var activeTextField : UITextField? = nil
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imgEx: [UIImage] = [UIImage(#imageLiteral(resourceName: "Nemo")),UIImage(#imageLiteral(resourceName: "Sully")),UIImage(#imageLiteral(resourceName: "Woody"))]
    var namaFilm = ["Finding Nemo", "Monster Inc", "Toy Story"]
    var namaKarakter = ["Marli", "Sulley", "Woody "]
    var wEx = ["Wants: Protect Nemo","Wants: Be the best scarer","Wants: To be Andy’s favorite toy"]
    var nEx = ["Needs: Learn to trust his son","Needs: Be a father figure","Needs: Learn to share his friendship"]
    var gEx = ["Goals: Find Nemo","Goals: Return Boo to her room","Goals: Get rid of Buzz Lightyear"]
    var obsEx = ["Obstacles: His son Nemo is missing","Obstacles: Discover a human child","Obstacles: A new space ranger toy may replace him"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CoreViewController.backgroundTap))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CoreViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
          
        NotificationCenter.default.addObserver(self, selector: #selector(CoreViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
        
        
        wantsTf.delegate = self
        needsTf.delegate = self
        goalsTf.delegate = self
        obsTf.delegate = self
        
        

        if CharLandingViewController.newItem == false {
            
            loadItems()
            
            wantsTf.text = CharLandingViewController.selectedChars?.wants
            needsTf.text = CharLandingViewController.selectedChars?.needs
            goalsTf.text = CharLandingViewController.selectedChars?.goals
            obsTf.text = CharLandingViewController.selectedChars?.obstacles
            
        }else {
            loadItems()
            
            wantsTf.text = CharLandingViewController.itemArray.last?.wants
            needsTf.text = CharLandingViewController.itemArray.last?.needs
            goalsTf.text = CharLandingViewController.itemArray.last?.goals
            obsTf.text = CharLandingViewController.itemArray.last?.obstacles
        }
        
        
        
        premisLbl.text = CharViewController.selectedStory?.premis
        collectionView.layer.cornerRadius = 12
        collectionView.layer.shadowRadius = 5
        collectionView.clipsToBounds = false
        collectionView.layer.masksToBounds = false
        
        navigationController?.navigationBar.tintColor = UIColor(named: "ButtonColor")
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wEx.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coreCell", for: indexPath) as! CoreCollectionViewCell
        cell.imageEx.image = imgEx[indexPath.item]
        cell.namaFilm.text = namaFilm[indexPath.item]
        cell.charNameEx.text = namaKarakter[indexPath.item]
        cell.wantsEx.text = wEx[indexPath.item]
        cell.needsEx.text = nEx[indexPath.item]
        cell.goaldsEx.text = gEx[indexPath.item]
        cell.obsEx.text = obsEx[indexPath.item]
        
        cell.layer.cornerRadius = 12
        cell.layer.backgroundColor = UIColor.white.cgColor
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.layer.shadowOpacity = 1
        cell.layer.shadowRadius = 1.0
        cell.clipsToBounds = false
        cell.layer.masksToBounds = false
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 700, height: 104)
    }
    
    func loadItems(with request: NSFetchRequest<Characters> = Characters.fetchRequest(), predicate: NSPredicate? = nil) {
        
        if CharViewController.selectedStory != nil {
            let categoryPredicate = NSPredicate(format: "parentStory.title MATCHES %@", CharViewController.selectedStory!.title!)
            
            if let addtionalPredicate = predicate {
                request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
            } else {
                request.predicate = categoryPredicate
            }

            
            do {
                itemArray = try context.fetch(request)
            } catch {
                print("Error fetching data from context \(error)")
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
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
       
        if CharLandingViewController.newItem != false{
            
            
            let alert = UIAlertController(title: "Character Saved", message: "You can develop more on Character Details", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            
                CharLandingViewController.itemArray.last?.setValue(self.name, forKey: "name")
                CharLandingViewController.itemArray.last?.setValue(self.wantsTf.text, forKey: "wants")
                CharLandingViewController.itemArray.last?.setValue(self.needsTf.text, forKey: "needs")
                CharLandingViewController.itemArray.last?.setValue(self.goalsTf.text, forKey: "goals")
                CharLandingViewController.itemArray.last?.setValue(self.obsTf.text, forKey: "obstacles")
                
                self.saveItems()
                
                self.navigationController?.popViewController(animated: true)
        }
        
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
            
            
        } else {
            
            let alert = UIAlertController(title: "Character Saved", message: "Your changes have been saved", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            
                
                
                // untuk important value
                
                CharLandingViewController.selectedChars?.setValue(self.wantsTf.text, forKey: "wants")
                CharLandingViewController.selectedChars?.setValue(self.needsTf.text, forKey: "needs")
                CharLandingViewController.selectedChars?.setValue(self.goalsTf.text, forKey: "goals")
                CharLandingViewController.selectedChars?.setValue(self.obsTf.text, forKey: "obstacles")
            
                self.saveItems()
                
                self.navigationController?.popViewController(animated: true)
            
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }
        
        
        
        
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
            self.view.frame.origin.y = 0 - keyboardSize.height
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
    
        
    
}

extension CoreViewController : UITextFieldDelegate {
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
