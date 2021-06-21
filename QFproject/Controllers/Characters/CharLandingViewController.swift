//
//  CharLandingViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 08/06/21.
//

import UIKit
import CoreData

class CharLandingViewController: UIViewController {

    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var charNameTf: UITextField!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var coreBtn: UIButton!
    @IBOutlet weak var detailBtn: UIButton!
    
    
    static var selectedChars: Characters?
    
    @IBOutlet weak var horizontalBar: ProgressBar!
    
    static var itemArray = [Characters]()
    
    static var newItem = true
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let spacing = 10
   
    var importanStatus = ""
    var nama = ""
    var check:Bool = false
    
    var imageName = ""
    
    var imageViewnya = UIImageView()
    
    
    
    @IBOutlet weak var viewDevProg: UIView!
    
    
    var progress: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()

        
        if CharLandingViewController.newItem == false {
            
            loadItems()
            charNameTf.text = CharLandingViewController.selectedChars?.name
            charNameTf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
            floatingButton()
            
            coreBtn.isEnabled = true
            coreBtn.alpha = 1
            detailBtn.isEnabled = true
            detailBtn.alpha = 1
            
            image1.alpha = 1
            image2.alpha = 1
            
            chooseButton.setTitle(CharLandingViewController.selectedChars?.important, for: .normal)
            
            progress = 0.0
            horizontalBar.progress = 0.0
            horizontalBar.holder = 0.0
            
            hitungProgress(item: false)
            horizontalBar.progress = progress
            
            
            
            
        }else{
            
            loadItems()
            charNameTf.text = CharLandingViewController.itemArray.last?.name
            charNameTf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            floatingButton()
            
            coreBtn.isEnabled = false
            coreBtn.alpha = 0.5
            detailBtn.isEnabled = false
            detailBtn.alpha = 0.5
            
            image1.alpha = 0.5
            image2.alpha = 0.5
            
            progress = 0.0
            horizontalBar.progress = 0.0
            horizontalBar.holder = 0.0
            
            hitungProgress(item: true)
            horizontalBar.progress = progress
        }
       appe()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {

        if CharLandingViewController.newItem == false {
            CharLandingViewController.selectedChars?.setValue(charNameTf.text, forKey: "name")
            
        }else{
            CharLandingViewController.itemArray.last?.setValue(charNameTf.text, forKey: "name")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        saveItems()
        loadItems()
    
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        saveItems()
        
        progress = 0.0
        horizontalBar.progress = 0.0
        horizontalBar.holder = 0.0
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveItems()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        splitViewController?.preferredDisplayMode = .oneBesideSecondary

        if CharLandingViewController.newItem == false {
            loadItems()
            progress = 0.0
            horizontalBar.progress = 0.0
            horizontalBar.holder = 0.0
            
            hitungProgress(item: false)
            horizontalBar.progress = progress
            

        }else {

            loadItems()
            progress = 0.0
            horizontalBar.progress = 0.0
            horizontalBar.holder = 0.0
            
            hitungProgress(item: true)
            horizontalBar.progress = progress
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
                CharLandingViewController.itemArray = try context.fetch(request)
            } catch {
                print("Error fetching data from context \(error)")
            }
            
       
        }
        
    }
    
    func addMenuItems() -> UIMenu {
        let menuItems = UIMenu(title: "", options: .displayInline, children: [
            
            UIAction(title: "Very important", image: UIImage(systemName: ""), handler: { [self]
                (_) in self.chooseButton.setTitle("Very Important", for: .normal)
                self.importanStatus = "Very Important"
                self.coreBtn.isEnabled = true
                self.detailBtn.isEnabled = true
                
                self.coreBtn.alpha = 1
                self.detailBtn.alpha = 1
                
                self.image1.alpha = 1
                self.image2.alpha = 1
                
                if CharLandingViewController.newItem == false {
                    CharLandingViewController.selectedChars?.setValue(self.importanStatus, forKey: "important")
                    self.saveItems()
                    
                    self.progress = 0
                    self.horizontalBar.progress = 0
                    self.hitungProgress(item: false)
                    self.horizontalBar.progress = self.progress
                }else {
                    CharLandingViewController.itemArray.last?.setValue(self.importanStatus, forKey: "important")
                    self.saveItems()
                    
                    self.progress = 0
                    self.horizontalBar.progress = 0
                    self.hitungProgress(item: true)
                    self.horizontalBar.progress = self.progress
                }
                
            }),
            
            UIAction(title: "Important", image: UIImage(systemName: ""), handler: {
                (_) in self.chooseButton.setTitle("Important", for: .normal)
                self.importanStatus = "Important"
                self.coreBtn.isEnabled = true
                self.detailBtn.isEnabled = true
                self.coreBtn.alpha = 1
                self.detailBtn.alpha = 1
                
                self.image1.alpha = 1
                self.image2.alpha = 1
                
                if CharLandingViewController.newItem == false {
                    CharLandingViewController.selectedChars?.setValue(self.importanStatus, forKey: "important")
                    self.saveItems()
                    
                    self.progress = 0
                    self.horizontalBar.progress = 0
                    self.hitungProgress(item: false)
                    self.horizontalBar.progress = self.progress
                }else {
                    CharLandingViewController.itemArray.last?.setValue(self.importanStatus, forKey: "important")
                    self.saveItems()
                    
                    self.progress = 0
                    self.horizontalBar.progress = 0
                    self.hitungProgress(item: true)
                    self.horizontalBar.progress = self.progress
                }
            }),
            
            UIAction(title: "Less important", image: UIImage(systemName: ""), handler: {
                (_) in self.chooseButton.setTitle("Less Important", for: .normal)
                self.importanStatus = "Not Important"
                self.coreBtn.isEnabled = true
                self.detailBtn.isEnabled = true
                self.coreBtn.alpha = 1
                self.detailBtn.alpha = 1
                
                self.image1.alpha = 1
                self.image2.alpha = 1
                
                if CharLandingViewController.newItem == false {
                    CharLandingViewController.selectedChars?.setValue(self.importanStatus, forKey: "important")
                    self.saveItems()
                    
                    self.progress = 0
                    self.horizontalBar.progress = 0
                    self.hitungProgress(item: false)
                    self.horizontalBar.progress = self.progress
                }else {
                    CharLandingViewController.itemArray.last?.setValue(self.importanStatus, forKey: "important")
                    self.saveItems()
                    
                    self.progress = 0
                    self.horizontalBar.progress = 0
                    self.hitungProgress(item: true)
                    self.horizontalBar.progress = self.progress
                }
            })
        
        ])
        
        return menuItems
    }
    
    
    func saveItems() {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "CharViewController") as! CharViewController
       
        
        do {
          try context.save()
            
            
        } catch {
           print("Error saving context \(error)")
        }
        
        
        secondViewController.loadItems()
       
    }
    
    func buttonAdd() {
        

            let newItem = Characters(context: self.context)
            newItem.name = charNameTf.text
            newItem.addInfoPhyco = importanStatus
            newItem.parentStory = CharViewController.selectedStory
            
        CharLandingViewController.itemArray.append(newItem)
            self.saveItems()
            
        
        

    }
    
    @IBAction func coreExplore(_ sender: UIButton) {
       // buttonAdd()
        
        if CharLandingViewController.newItem == true {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "CoreViewController") as! CoreViewController
            secondViewController.name = charNameTf.text ?? ""
            secondViewController.important = importanStatus
            secondViewController.check2 = false
            
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }else {
            
            performSegue(withIdentifier: "goJek", sender: self)
            
            
            
        }
       
    }
    
    @IBAction func detailExplore(_ sender: UIButton) {
        if CharLandingViewController.newItem == false {
            //performSegue(withIdentifier: "goNew", sender: self)
            //CharLandingViewController.newItem = true
            let storyboard = UIStoryboard(name: "Room", bundle: nil)
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "WritersRoomViewController") as! WritersRoomViewController
          
            secondViewController.modalPresentationStyle = .fullScreen
            present(secondViewController, animated: true, completion: nil)
            
            
        }else {
           // performSegue(withIdentifier: "goDetail", sender: self)
            
           // CharLandingViewController.newItem = false
            
            let storyboard = UIStoryboard(name: "Room", bundle: nil)
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "WritersRoomViewController") as! WritersRoomViewController
          
            secondViewController.modalPresentationStyle = .fullScreen
            present(secondViewController, animated: true, completion: nil)
            
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
       if segue.identifier == "goJek" {
            if let nextVC = segue.destination as? CoreViewController {
                
                nextVC.vc = ""
            
            }
            
       }else if segue.identifier == "goTo" {
        if let nextVC = segue.destination as? ProfileViewController {
            
            nextVC.name = CharLandingViewController.selectedChars?.name ?? ""
            nextVC.wants = CharLandingViewController.selectedChars?.wants ?? ""
            nextVC.needs = CharLandingViewController.selectedChars?.needs ?? ""
            nextVC.goals = CharLandingViewController.selectedChars?.goals ?? ""
            nextVC.obs = CharLandingViewController.selectedChars?.obstacles ?? ""
            
        
        }
       }else if segue.identifier == "goDetail" {
        if let nextVC = segue.destination as? WritersRoomViewController {
            
            nextVC.vc = ""
            
        }
       }else if segue.identifier == "goNew" {
        if let nextVC = segue.destination as? WritersRoomViewController {
            nextVC.vc = ""
        }
       }
    }
    
    @objc func toSheet() {
        performSegue(withIdentifier: "goTo", sender: self)
        
    }
    
    
    
    func floatingButton(){
        let btn = UIButton(type: .custom)
        
        btn.setImage(#imageLiteral(resourceName: "personal-data"), for: .normal)
        btn.addTarget(self, action: #selector(toSheet), for: .touchUpInside)
        btn.clipsToBounds = true
        btn.backgroundColor = UIColor(named: "BgColor")
        btn.layer.cornerRadius = 20
        btn.layer.borderColor = UIColor(named: "ButtonColor")?.cgColor
        btn.layer.borderWidth = 3.0
        view.addSubview(btn)
        
       
        func scrollViewDidScroll(_ scrollView: UIScrollView) {

               let  off = scrollView.contentOffset.y

               btn.frame = CGRect(x: 285, y:   off + 485, width: btn.frame.size.width, height: btn.frame.size.height)
        }
        
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 110).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 80).isActive = true
        btn.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -10).isActive = true
        btn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    }
    
    
    
    func hitungProgress(item: Bool) {
        if item == false {
            if CharLandingViewController.selectedChars?.important == "Very Important" {
                
                horizontalBar.holder = 0.875
                
            }else if CharLandingViewController.selectedChars?.important == "Important" {
                
                horizontalBar.holder = 0.5
                
            }else {
                
                horizontalBar.holder = 0.1700
            }
                            
            if CharLandingViewController.selectedChars?.photo != nil {
                progress += 0.0104
            }else {
                progress += 0.0
            }
            
            if CharLandingViewController.selectedChars?.gender == nil || CharLandingViewController.selectedChars?.gender == ""{
                progress += 0.0
            }else {
                progress += 0.0104
            }
            
            if CharLandingViewController.selectedChars?.age == nil || CharLandingViewController.selectedChars?.age == "" {
                progress += 0.0
            }else {
                progress += 0.0104
            }
            
            if CharLandingViewController.selectedChars?.skin == nil || CharLandingViewController.selectedChars?.skin == "" {
                progress += 0.0
            }else {
                progress += 0.0104
            }
            
            if CharLandingViewController.selectedChars?.appearances == nil || CharLandingViewController.selectedChars?.appearances == ""{
                progress += 0.0
            }else {
                progress += 0.0104
            }
            
            if CharLandingViewController.selectedChars?.posture == nil || CharLandingViewController.selectedChars?.posture == ""{
                progress += 0.0
            }else {
                progress += 0.0104
            }
            
            if CharLandingViewController.selectedChars?.temprament == nil || CharLandingViewController.selectedChars?.temprament == ""{
                progress += 0.0
            }else {
                progress += 0.0625
            }
            
            if CharLandingViewController.selectedChars?.community == nil || CharLandingViewController.selectedChars?.community == ""{
                progress += 0.0
            }else {
                progress += 0.0625
            }
            
            if CharLandingViewController.selectedChars?.intelligence == nil || CharLandingViewController.selectedChars?.intelligence == ""{
                progress += 0.0
            }else {
                progress += 0.0625
            }
            
            if CharLandingViewController.selectedChars?.perspective == nil || CharLandingViewController.selectedChars?.perspective == ""{
                progress += 0.0
            }else {
                progress += 0.0625
            }
            
            if CharLandingViewController.selectedChars?.personality == nil || CharLandingViewController.selectedChars?.personality == ""{
                progress += 0.0
            }else {
                progress += 0.0625
            }
            
            if CharLandingViewController.selectedChars?.economiClass == nil || CharLandingViewController.selectedChars?.economiClass == "" {
                progress += 0.0
            }else {
                progress += 0.0625
            }
            
            if CharLandingViewController.selectedChars?.significantMoment == nil || CharLandingViewController.selectedChars?.significantMoment == ""{
                progress += 0.0
            }else {
                progress += 0.0312
            }
            
            if CharLandingViewController.selectedChars?.significantPerson == nil || CharLandingViewController.selectedChars?.significantPerson == "" {
                progress += 0.0
            }else {
                progress += 0.0312
            }
            
            if CharLandingViewController.selectedChars?.routines == nil || CharLandingViewController.selectedChars?.routines == ""{
                progress += 0.0
            }else {
                progress += 0.0312
            }
            
            if CharLandingViewController.selectedChars?.hobby == nil || CharLandingViewController.selectedChars?.hobby == ""{
                progress += 0.0
            }else {
                progress += 0.0312
            }
            
            if CharLandingViewController.selectedChars?.wants == nil || CharLandingViewController.selectedChars?.wants == ""{
                progress += 0.0
            }else {
                progress += 0.0625
            }
            
            if CharLandingViewController.selectedChars?.needs == nil || CharLandingViewController.selectedChars?.needs == ""{
                progress += 0.0
            }else {
                progress += 0.0625
            }
            
            if CharLandingViewController.selectedChars?.goals == nil || CharLandingViewController.selectedChars?.goals == ""{
                progress += 0.0
            }else {
                progress += 0.0625
            }
           
            if CharLandingViewController.selectedChars?.obstacles == nil || CharLandingViewController.selectedChars?.obstacles == "" {
                progress += 0.0
            }else {
                progress += 0.0625
            }
                
                
            horizontalBar.progress = progress
              
                
        }
                
                
        else{
            if CharLandingViewController.itemArray.last?.important == "Very Important" {
                
                horizontalBar.holder = 0.875
                
            }else if CharLandingViewController.itemArray.last?.important == "Important" {
                
                horizontalBar.holder = 0.5
                
            }else {
                
                horizontalBar.holder = 0.1700
            }
            
            
            if CharLandingViewController.itemArray.last?.photo != nil {
                   progress += 0.0104
               }else {
                   progress += 0.0
               }

               if CharLandingViewController.itemArray.last?.gender == nil || CharLandingViewController.itemArray.last?.gender == ""{
                   progress += 0.0
               }else {
                   progress += 0.0104
               }


               if CharLandingViewController.itemArray.last?.age == nil || CharLandingViewController.itemArray.last?.age == "" {
                   progress += 0.0
               }else{
                   progress += 0.0104
               }

               if CharLandingViewController.itemArray.last?.skin == nil || CharLandingViewController.itemArray.last?.skin == "" {
                   progress += 0.0
               }else{
                   progress += 0.0104
               }

               if CharLandingViewController.itemArray.last?.appearances == nil || CharLandingViewController.itemArray.last?.skin == ""{
                   progress += 0.0
               }else{
                   progress += 0.0104
               }

               if CharLandingViewController.itemArray.last?.posture == nil || CharLandingViewController.itemArray.last?.posture == ""{
                   progress += 0.0
               }else{
                   progress += 0.0104
               }

               if CharLandingViewController.itemArray.last?.temprament == nil || CharLandingViewController.itemArray.last?.temprament == ""{
                   progress += 0.0
               }else{
                   progress += 0.0625
               }

               if CharLandingViewController.itemArray.last?.community == nil || CharLandingViewController.itemArray.last?.community == ""{
                   progress += 0.0
               }else{
                   progress += 0.0625
               }

               if CharLandingViewController.itemArray.last?.intelligence == nil || CharLandingViewController.itemArray.last?.intelligence == ""{
                   progress += 0.0
               }else{
                   progress += 0.0625
               }

               if CharLandingViewController.itemArray.last?.perspective == nil || CharLandingViewController.itemArray.last?.perspective == ""{
                   progress += 0.0
               }else{
                   progress += 0.0625
               }

               if CharLandingViewController.itemArray.last?.personality == nil || CharLandingViewController.itemArray.last?.personality == ""{
                   progress += 0.0
               }else{
                   progress += 0.0625
               }

               if CharLandingViewController.itemArray.last?.economiClass == nil || CharLandingViewController.itemArray.last?.economiClass == "" {
                   progress += 0.0
               }else{
                   progress += 0.0625
               }

               if CharLandingViewController.itemArray.last?.significantMoment == nil || CharLandingViewController.itemArray.last?.significantMoment == ""{
                   progress += 0.0
               }else{
                   progress += 0.0312
               }

               if CharLandingViewController.selectedChars?.significantPerson == nil || CharLandingViewController.itemArray.last?.significantPerson == "" {
                   progress += 0.0
               }else{
                   progress += 0.0312
               }

               if CharLandingViewController.itemArray.last?.routines == nil || CharLandingViewController.itemArray.last?.routines == ""{
                   progress += 0.0
               }else{
                   progress += 0.0625
               }

               if CharLandingViewController.itemArray.last?.hobby == nil || CharLandingViewController.itemArray.last?.hobby == ""{
                   progress += 0.0
               }else{
                   progress += 0.0625
               }

               if CharLandingViewController.itemArray.last?.wants == nil || CharLandingViewController.itemArray.last?.wants == ""{
                   progress += 0.0
               }else{
                   progress += 0.0625
               }

               if CharLandingViewController.itemArray.last?.needs == nil || CharLandingViewController.itemArray.last?.needs == ""{
                   progress += 0.0
               }else{

                   progress += 0.0625
               }

               if CharLandingViewController.itemArray.last?.goals == nil || CharLandingViewController.itemArray.last?.goals == ""{
                   progress += 0.0
               }else{

                   progress += 0.0625
               }

               if CharLandingViewController.itemArray.last?.obstacles == nil || CharLandingViewController.itemArray.last?.obstacles == "" {
                   progress += 0.0
               }else{
                   progress += 0.0625
               }


           horizontalBar.progress = progress

        }
                
            
    }
    
    
    
    func appe() {
        chooseButton.showsMenuAsPrimaryAction = true
        chooseButton.layer.cornerRadius = 12
        chooseButton.menu = addMenuItems()
        chooseButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        chooseButton.tintColor = UIColor(named: "ButtonColor")
       
        
        image1.layer.cornerRadius = 12
        image1.layer.borderWidth = 1
        image1.layer.borderColor = UIColor(named: "ButtonColor")?.cgColor
        
        image2.layer.cornerRadius = 12
        image2.layer.borderWidth = 1
        image2.layer.borderColor = UIColor(named: "ButtonColor")?.cgColor
        
        coreBtn.layer.cornerRadius = 12
        detailBtn.layer.cornerRadius = 12
        
        
        navigationController?.navigationBar.tintColor = UIColor(named: "ButtonColor")
    }
    
}


class ButtonWithImage: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
        }
    }

}

