//
//  AddCharViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 19/06/21.
//

import UIKit
import CoreData

class AddCharViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    static var character: Characters?
    
    var itemArray = [Characters]()
    
    
    private let spacing:CGFloat = 16.0
    
    var onCreate: (() -> Void)?
    
    static var selectedCharacter: Characters?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AddCollectionViewCell
        
        
        
        let item = itemArray[indexPath.row]
        cell.image.layer.cornerRadius = 12
        cell.image.layer.borderWidth = 1
        cell.image.layer.borderColor = UIColor(named: "ButtonColor")?.cgColor
        cell.name.text = item.name
        
        if item.photo != nil {
            cell.image.image = UIImage(data: item.photo!)
        } else {
            cell.image.image = UIImage(named: "orang")
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        
        let item = itemArray[indexPath.row]
        AddCharViewController.selectedCharacter = item
        
        guard
        let vc = presentingViewController as? CanvasViewController
            
        else {
            return
        }
        
        let profileImage = UIImage(named:"orang")!
        let imageData = profileImage.pngData()
        var i = 0
        
        if itemArray[indexPath.row].photo != nil {
            vc.addGambar(imageData: itemArray[indexPath.row].photo!)
        }else {
            vc.addGambar(imageData: imageData!)
        }
        
        i += 20
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfItemsPerRow:CGFloat = 3
        let spacingBetweenCells:CGFloat = 50
        
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
                
        if let collection = self.collectionView{
            
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width)
                
        }else{
                    return CGSize(width: 0, height: 0)
                }
        
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
    
   
    
    

}


