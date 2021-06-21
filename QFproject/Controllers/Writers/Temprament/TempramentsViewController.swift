//
//  TempramentsViewController.swift
//  writersRoom
//
//  Created by Ricksen Tanata on 11/06/21.
//

import UIKit
import CoreData

class TempramentsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    
    @IBOutlet weak var temprament: UICollectionView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
  //  var selected: Stories?
    var itemArray = [Characters]()
    
  //  var index = 0
    
    var tempt = ""
    
    var check: Bool = true
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadItems()
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = temprament.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TempramentsCollectionViewCell
        cell.layer.cornerRadius = 23
        cell.layer.backgroundColor = UIColor(named: "PlaceholderColor")?.cgColor
       // cell.layer.borderWidth = 1
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSize(width: 4, height: 4)
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowRadius = 1.0
        
        
        let view = UIView(frame: cell.layer.bounds)
            view.backgroundColor = UIColor(named: "ButtonColor")
            cell.selectedBackgroundView = view
        
        if indexPath.row == 0 {
         
            cell.tempTitle.text = "Melancholic"
            cell.desc1.text = "Idealist . \n Have high standards . \n Deep thinkers"
            cell.strengh.text = "Thoughtful, analytical, empathetic to others, good listener, prone to creativity"
            cell.weekness.text = "Unrealistic expectations, concerned with perfection, moody, critical of self & others, slow to make decisions"
            
            
            
        }else if indexPath.row == 1{
       
            cell.tempTitle.text = "Choleric"
            cell.desc1.text = "Authoritative . \n Love Competitions . \n Daring"
            cell.strengh.text = "Good at making decisions, Analytical, Logical, Determined, Direct"
            cell.weekness.text = "Argumentative, Domineering, Competitive, Quick-tempered, Impatient"
            
            
        }else if indexPath.row == 2{
            cell.tempTitle.text = "Sanguine"
            cell.desc1.text = "Social . \n Expressive . \n Love Attention"
            cell.strengh.text = "Storyteller, Optimistic, Makes friend easily, Entertaining, Cheerful & Enthusiastic"
            cell.weekness.text = "Compulsive talker, Impulsive, Undisciplined, Disorganized, Has trouble listening, Forgetful"
            
            
        }else if indexPath.row == 3{
            cell.tempTitle.text = "Phlegmatic"
            cell.desc1.text = "Relaxed & Quiet . \n Like Peace . \n Avoid Conflict"
            cell.strengh.text = "Calm & Collected, Good Under, Pressure, Accomodating, Dependable, Practical & Efficient"
            cell.weekness.text = "Unenthusiastic, Indecisive, Can be too compromising, Procrastinates, Can be, Uninvolved"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            tempt = "Melancholic"
            
            
        }else if indexPath.row == 1 {
            tempt = "Choleric"
            
            
        }else if indexPath.row == 2 {
            tempt = "Sanguine"
         
            
        }else {
            tempt = "Phlegmatic"
           
            
        }
        
    }
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        
        guard
            let vc = presentingViewController as? WritersRoomViewController
        else {
            return
        }
        
        let alert = UIAlertController(title: "Character Saved", message: "Your changes have been saved", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default) { (action) in
        
            
            // untuk important value
            
            CharLandingViewController.selectedChars?.setValue(self.tempt, forKey: "temprament")
        
            self.saveItems()
            self.dismiss(animated: true, completion: {
                vc.alernya()
            })
        
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        
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

extension TempramentsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 275, height: 470)
    }
}
