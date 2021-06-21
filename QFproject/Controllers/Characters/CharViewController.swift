//
//  CharViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 07/06/21.
//

import UIKit
import CoreData

class CharViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var createButton: UIButton!
    
    var itemArray = [Characters]()
    
    var check = 0
    
    @IBOutlet weak var sTitle: UILabel!
    @IBOutlet weak var sDesc: UILabel!
    @IBOutlet weak var newDesc: UILabel!
    @IBOutlet weak var newImg: UIImageView!
    @IBOutlet weak var newButton: UIButton!
    
    
    var judul = ""
    var premis = ""
    
    var imageName = "person"
    
    private let spacing:CGFloat = 16.0
    
//    var selectedStory: Stories? {
//        didSet{
//            loadItems()
//        }
//    }
    
    static var selectedStory: Stories? 
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var editModeEnabled = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        loadItems()
        floatingButton()
        
        
        sTitle.text = judul
        sDesc.text = premis
        
        createButton.layer.cornerRadius = 12
        
        if check == 0 {
            collectionView.isHidden = true
            sTitle.isHidden = true
            sDesc.isHidden = true
           
        } else {
            sTitle.isHidden = false
            sDesc.isHidden = false
            newImg.isHidden = true
            newButton.isHidden = true
            newDesc.isHidden = true
        }
       
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadItems()
        splitViewController?.preferredDisplayMode = .oneBesideSecondary
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadItems()
        splitViewController?.preferredDisplayMode = .oneBesideSecondary
        collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray.count + 1
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CharacterCollectionViewCell
        
        
        if indexPath.item == 0 {
            
            cell.CcImage.image = UIImage(named: "AddCharacter")
            cell.ccLbl.text = "Add new"
            cell.CcImage.layer.borderColor = UIColor.black.cgColor
            cell.CcImage.layer.cornerRadius = 12
            cell.CcImage.layer.borderWidth = 1
            
            
            cell.deleteButton.isHidden = true
            cell.deleteBackgroundView.isHidden = !isEditing
            
            
            if isEditing {
                cell.contentView.alpha = 0.5
            }else {
                cell.contentView.alpha = 1
            }
            
            
        } else {
            let item = itemArray[indexPath.row - 1]
            
            
            if item.photo != nil {
                cell.imageNamed = UIImage(data: item.photo!)
                    
            }else {
                cell.imageNamed = UIImage(named: "orang")
            }
            
            
            cell.ccLbl.text = item.name
            
           // cell.CcImage.layer.masksToBounds = true
            cell.CcImage.layer.borderColor = UIColor.black.cgColor
            cell.CcImage.layer.cornerRadius = 12
            cell.CcImage.layer.borderWidth = 1
            
            cell.delegate = self
            
            
        }
        
        return cell
    }
    
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if !isEditing {
            if indexPath.item == 0{
              
                
                var textField = UITextField()
                
                let alert = UIAlertController(title: "Add New Character", message: "Please fill in character name", preferredStyle: .alert)
                
                let cancel = UIAlertAction(title: "Cancel", style: .cancel)
                
            
                
                let action = UIAlertAction(title: "Save", style: .default) { (action) in
                    
                    let newChar = Characters(context: self.context)
                    
                    newChar.name = textField.text!
                    newChar.parentStory = CharViewController.selectedStory
                    
                    CharLandingViewController.itemArray.append(newChar)
                    self.saveItems()
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let secondViewController = storyboard.instantiateViewController(withIdentifier: "CharLandingViewController") as! CharLandingViewController
                    secondViewController.check = true
                    CharLandingViewController.newItem = true
                    self.navigationController?.pushViewController(secondViewController, animated: true)
                    
                }
                
                alert.addAction(action)
                alert.addAction(cancel)
                
                alert.addTextField { (field) in
                    textField = field
                    textField.placeholder = "Add a new character name"
                }
                
                present(alert, animated: true, completion: nil)
                
                
            }else {
                if let cell = collectionView.cellForItem(at: indexPath) {
                        self.performSegue(withIdentifier: "goSend", sender: cell)
                    }
                
                
            }
        }
       
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goSend" {
            
            
           if let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell) {
            
            let controller = segue.destination as! CharLandingViewController
            
            
            let item = itemArray[indexPath.row - 1]
            
            CharLandingViewController.newItem = false
            
                if controller.charNameTf?.text != nil {
                    
                    
                    controller.charNameTf.text = item.name
                    controller.chooseButton.setTitle(item.addInfoPhyco, for: .normal)
                    
                }else {
                    
                    controller.nama = item.name ?? ""
                    controller.importanStatus = item.addInfoPhyco ?? ""
                    CharLandingViewController.selectedChars = item
                    
                    
                }
        }
            
        }else if segue.identifier == "goCanvas" {
            if let canvas = segue.destination as? CanvasViewController {
                canvas.vc = ""
            }
        }
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
    
    //MARK: - DeleteItem
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        
        
        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            
            for indexPath in indexPaths {
                if let cell = collectionView?.cellForItem(at: indexPath) as? CharacterCollectionViewCell {
                    cell.isEditing = editing
                    
                    if indexPath.row == 0 {
                        cell.deleteBackgroundView.isHidden = true
                        
                        if isEditing {
                            cell.contentView.alpha = 0.5
                        }else {
                            cell.contentView.alpha = 1
                        }
                        
                    }
                    
                }
            }
        }
        
        
        
    }
    

    func saveItems() {
        
        do {
          try context.save()
        } catch {
           print("Error saving context \(error)")
        }
        
        self.collectionView.reloadData()
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
    
    @objc func toCanvas() {
      // performSegue(withIdentifier: "goCanvas", sender: self)
//
        let storyboard = UIStoryboard(name: "Canvas", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "CanvasViewController") as! CanvasViewController

        
        secondViewController.modalPresentationStyle = .fullScreen
        present(secondViewController, animated: true, completion: nil)
    }
    
    func floatingButton(){
        let btn = UIButton(type: .custom)
       // btn.frame = CGRect(x: 700, y: 700, width: 128, height: 99)
        
        btn.setImage(#imageLiteral(resourceName: "Mind Map Icons"), for: .normal)
        btn.addTarget(self, action: #selector(toCanvas), for: .touchUpInside)
        btn.clipsToBounds = true
       // btn.layer.cornerRadius = 20
      //  btn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      //  btn.layer.borderWidth = 3.0
        view.addSubview(btn)
        
        if check == 0 {
            btn.isHidden = true
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {

               let  off = scrollView.contentOffset.y

               btn.frame = CGRect(x: 285, y:   off + 485, width: btn.frame.size.width, height: btn.frame.size.height)
        }
        
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 128).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 122).isActive = true
        btn.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -10).isActive = true
        btn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
               //floatingButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    
    
    func buttonAdd() {
        var textField = UITextField()
        var textField2 = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            
            
            let newItem = Characters(context: self.context)
            newItem.name = textField.text!
            newItem.wants = textField2.text!
            newItem.parentStory = CharViewController.selectedStory
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addTextField { (alertTextFieldC) in
            alertTextFieldC.placeholder = "Add wants"
            textField2 = alertTextFieldC
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func newButtonAct(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "NewStoryViewController") as! NewStoryViewController
        secondViewController.modalPresentationStyle = .fullScreen
        //self.present(secondViewController, animated: true, completion: nil)
        
        let navBarOnModal: UINavigationController = UINavigationController(rootViewController: secondViewController)
        self.present(navBarOnModal, animated: true, completion: nil)
    
    }
    
    
}


extension CharViewController: CharCellDelegate {
    func delete(cell: CharacterCollectionViewCell) {
        if let indexPath = collectionView?.indexPath(for: cell) {
            // delete from data source
            
            context.delete(itemArray[indexPath.row - 1])
            itemArray.remove(at: indexPath.row - 1)
            
            //delete from cell index
            collectionView?.deleteItems(at: [indexPath])
            
            
        }
    }
    
    
}
