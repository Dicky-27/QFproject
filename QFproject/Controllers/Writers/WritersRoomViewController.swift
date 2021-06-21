//
//  WritersRoomViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 11/06/21.
//

import UIKit
import CoreData

class WritersRoomViewController: UIViewController {
    
    @IBOutlet weak var todoButton: UIButton!
    @IBOutlet weak var polaroidButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var laptopButon: UIButton!
    @IBOutlet weak var legoButton: UIButton!
    @IBOutlet weak var glassButton: UIButton!
    @IBOutlet weak var piggyButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var rubickButton: UIButton!
    @IBOutlet weak var bookButton: UIButton!
    
    
    
    @IBOutlet weak var horizontalBar: ProgressBar!
    @IBOutlet weak var viewImage: UIView!
    
    var holder: CGFloat = 0.0
    var imageName = ""
    var vc = ""
    var progress: CGFloat = 0.0
    var itemArray = [Characters]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK : - Typecasting
    
    
    var cek = 0
    
        

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        loadItems()
        
        let backgroundImage = UIImage.init(named: "Background Environment-1")
            let backgroundImageView = UIImageView.init(frame: self.view.frame)

            backgroundImageView.image = backgroundImage
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.alpha = 1

            self.view.insertSubview(backgroundImageView, at: 0)
        
        

       
        let img = UIImage(named: "nBackground Environment-1")
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        
        
        if CharLandingViewController.newItem == false {
            
            progress = 0.0
            horizontalBar.progress = 0.0
            horizontalBar.holder = 0.0
            
            hitungProgress(item: false)
            horizontalBar.progress = progress
            
            
           disableButton()
            
        }else {
            
            progress = 0.0
            horizontalBar.progress = 0.0
            horizontalBar.holder = 0.0
            
            hitungProgress(item: true)
            horizontalBar.progress = progress
            
            disableButtonDua()
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    
    
    @IBAction func piggyBank(_ sender: UIButton) {
        performSegue(withIdentifier: "goKaya", sender: self)
    }
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func bookButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goBook", sender: self)
    }
    
    
    @IBAction func laptopButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goLaptop", sender: self)
    }
    
    @IBAction func photoButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goImage", sender: self)
    }
    
    @IBAction func glassButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goGlass", sender: self)
    }
    @IBAction func phoneButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goPer", sender: self)
    }
    
    @IBAction func rubickButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goRubick", sender: self)
    }
    
    @IBAction func figureButton(_ sender: UIButton) {
         performSegue(withIdentifier: "goLego", sender: self)
    }
    
    @IBAction func photodiatasButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goIsi", sender: self)
    }
    
    @IBAction func todoButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goList", sender: self)
        
    }
   
    @IBAction func questionButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goLaptop" {
            if let nextVC = segue.destination as? TempramentsViewController {
                nextVC.loadItems()
            }
            
        }else if segue.identifier == "goImage" {
            if let nextVC = segue.destination as? ImageViewController {
                nextVC.vc = ""
            }
        }else if segue.identifier == "goBook" {
            if let nextVC = segue.destination as? BookViewController {
                nextVC.vc = ""
            }
        }else if segue.identifier == "goGlass" {
            if let nextVC = segue.destination as? GlassViewController {
                nextVC.vc = ""
                
            }
        }else if segue.identifier == "goKaya" {
            if let nextVC = segue.destination as? PiggyViewController {
                nextVC.vc = ""
            }
        }else if segue.identifier == "goPer" {
            if let nextVC = segue.destination as? PersonalityViewController {
                nextVC.vc = ""
            }
        }else if segue.identifier == "goRubick" {
            
            if let nextVC = segue.destination as? RubickViewController {
                nextVC.vc = ""
            }
        }else if segue.identifier == "goLego" {
            if let nextVc = segue.destination as? LegoViewController {
                nextVc.vc = ""
            }
        }else if segue.identifier == "goList" {
            if let nextVC = segue.destination as? LeListViewController {
                nextVC.vc = ""
            }
        }else if segue.identifier == "goIsi" {
            if let nextVc = segue.destination as? KeyboardViewController {
                nextVc.vc = ""
            }
        }else if segue.identifier == "goInfo" {
            if let nextVC = segue.destination as? InfoTableViewController {
                nextVC.vc = ""
            }
        }else {
            return
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
    
    func saveItems() {
        
        do {
          try context.save()
        } catch {
           print("Error saving context \(error)")
        }
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
           //disableButton()
            
           
            
//            if horizontalBar.progress >= horizontalBar.holder {
//                
//                let alert = UIAlertController(title: "Development Progess", message: "You already pass the threshold", preferredStyle: .alert)
//                let action = UIAlertAction(title: "Okay", style: .default) { (action) in
//                
//                    self.enableButton()
//
//                }
//                
//                alert.addAction(action)
//                present(alert, animated: true, completion: nil)
//                
//        }
                
                
        }else{
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
    
    
    func alernya() {
        
        if CharLandingViewController.newItem == false {
            
            progress = 0.0
            horizontalBar.progress = 0.0
            horizontalBar.holder = 0.0
            
            
            hitungProgress(item: false)
            
            if horizontalBar.progress >= horizontalBar.holder {
                let alert = UIAlertController(title: "Congrats!", message: "You've reached your development milestone. Explore more details about your character in Character Profile", preferredStyle: .alert)
                
                let cancel = UIAlertAction(title: "Cancel", style: .cancel)
                let action = UIAlertAction(title: "Go to Profile", style: .default) { (action) in
                
                    
                    self.enableButton()
                    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
                    let secondViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController

                    secondViewController.chek = true
                    
                    secondViewController.modalPresentationStyle = .fullScreen
                    self.present(secondViewController, animated: true, completion: nil)
                
                    
                }
                
                alert.addAction(cancel)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                
                
            }
            
        }else {
            
            progress = 0.0
            horizontalBar.progress = 0.0
            horizontalBar.holder = 0.0
            
            
            hitungProgress(item: true)
            
            if horizontalBar.progress >= horizontalBar.holder {
                let alert = UIAlertController(title: "Congrats!", message: "You've reached your development milestone. Explore more details about your character in Character Profile", preferredStyle: .alert)
                
                let cancel = UIAlertAction(title: "Cancel", style: .cancel)
                let action = UIAlertAction(title: "Go to Profile", style: .default) { (action) in
                
                    
                    self.enableButton()
                    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
                    let secondViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController

                    secondViewController.chek = true
                    
                    secondViewController.modalPresentationStyle = .fullScreen
                    self.present(secondViewController, animated: true, completion: nil)
                
                    
                }
                
                alert.addAction(cancel)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                
                
            }
            
            
        }
        
    }
    
   
    
    
    func disableButton() {

            if CharLandingViewController.selectedChars?.important == "Important"{
            
                progress = 0.0
                horizontalBar.progress = 0.0
                horizontalBar.holder = 0.0
                
                
                hitungProgress(item: false)
                
                if horizontalBar.progress >= horizontalBar.holder {
                    enableButton()
                }else {
                    
                        bookButton.setImage(#imageLiteral(resourceName: "bookNo"), for: .disabled)
                        
                        bookButton.isEnabled = false
                        
                        todoButton.isEnabled = true
                       
                        laptopButon.isEnabled = true
                        
                        photoButton.isEnabled = true
                        
                        polaroidButton.isEnabled = true
                        
                        rubickButton.isEnabled = true
                        
                        glassButton.isEnabled = true
                        
                        piggyButton.isEnabled = false
                        piggyButton.setImage(#imageLiteral(resourceName: "pigNo"), for: .disabled)
                        
                        
                        phoneButton.isEnabled = false
                        phoneButton.setImage(#imageLiteral(resourceName: "phoneNo"), for: .disabled)
                        
                        legoButton.isEnabled = false
                        legoButton.setImage(#imageLiteral(resourceName: "legoNo"), for: .disabled)
                }
           
                
                    
                
               
            }else if CharLandingViewController.selectedChars?.important == "Not Important" {
                progress = 0.0
                horizontalBar.progress = 0.0
                horizontalBar.holder = 0.0
                
                
                hitungProgress(item: false)
                
                if horizontalBar.progress >= horizontalBar.holder {
                    enableButton()
                }else{
                    
                    todoButton.setImage(#imageLiteral(resourceName: "toNo"), for: .disabled)
                    todoButton.isEnabled = false
                    
                    laptopButon.isEnabled = true
                    
                    photoButton.isEnabled = true
                    
                    polaroidButton.setImage(#imageLiteral(resourceName: "polNo"), for: .disabled)
                    polaroidButton.isEnabled = false
                    
                    rubickButton.setImage(#imageLiteral(resourceName: "rubNo"), for: .disabled)
                    rubickButton.isEnabled = false
                    
                    glassButton.setImage(#imageLiteral(resourceName: "glassNo"), for: .disabled)
                    glassButton.isEnabled = false
                    
                    piggyButton.setImage(#imageLiteral(resourceName: "pigNo"), for: .disabled)
                    piggyButton.isEnabled = false
                    
                    bookButton.setImage(#imageLiteral(resourceName: "bookNo"), for: .disabled)
                    bookButton.isEnabled = false
                    
                    
                    phoneButton.isEnabled = true
                    
                    legoButton.setImage(#imageLiteral(resourceName: "legoNo"), for: .disabled)
                    legoButton.isEnabled = false
                    
                }
                    
                
                
                
            }else {
                enableButton()
            }
        }
    
    func disableButtonDua() {
        
        if CharLandingViewController.itemArray.last?.important == "Important"{
            progress = 0.0
            horizontalBar.progress = 0.0
            horizontalBar.holder = 0.0
            
            
            hitungProgress(item: true)
        
            if horizontalBar.progress >= horizontalBar.holder {
                enableButton()
            }else{
                
                bookButton.setImage(#imageLiteral(resourceName: "bookNo"), for: .disabled)
                
                bookButton.isEnabled = false
                
                todoButton.isEnabled = true
               
                laptopButon.isEnabled = true
                
                photoButton.isEnabled = true
                
                polaroidButton.isEnabled = true
                
                rubickButton.isEnabled = true
                
                glassButton.isEnabled = true
                
                piggyButton.isEnabled = false
                piggyButton.setImage(#imageLiteral(resourceName: "pigNo"), for: .disabled)
                
                
                phoneButton.isEnabled = false
                phoneButton.setImage(#imageLiteral(resourceName: "phoneNo"), for: .disabled)
                
                legoButton.isEnabled = false
                legoButton.setImage(#imageLiteral(resourceName: "legoNo"), for: .disabled)
            }
            
                
                
            
            
            
        }else if CharLandingViewController.itemArray.last?.important == "Not Important" {
            progress = 0.0
            horizontalBar.progress = 0.0
            horizontalBar.holder = 0.0
            
            
            hitungProgress(item: true)
            
            if horizontalBar.progress >= horizontalBar.holder {
                enableButton()
            }else {
                todoButton.setImage(#imageLiteral(resourceName: "toNo"), for: .disabled)
                todoButton.isEnabled = false
                
                laptopButon.isEnabled = true
                
                photoButton.isEnabled = true
                
                polaroidButton.setImage(#imageLiteral(resourceName: "polNo"), for: .disabled)
                polaroidButton.isEnabled = false
                
                rubickButton.setImage(#imageLiteral(resourceName: "rubNo"), for: .disabled)
                rubickButton.isEnabled = false
                
                glassButton.setImage(#imageLiteral(resourceName: "glassNo"), for: .disabled)
                glassButton.isEnabled = false
                
                piggyButton.setImage(#imageLiteral(resourceName: "pigNo"), for: .disabled)
                piggyButton.isEnabled = false
                
                bookButton.setImage(#imageLiteral(resourceName: "bookNo"), for: .disabled)
                bookButton.isEnabled = false
                
                
                phoneButton.isEnabled = true
                
                legoButton.setImage(#imageLiteral(resourceName: "legoNo"), for: .disabled)
                legoButton.isEnabled = false
            
        
            }
        
        }else {
            
            enableButton()
        }
    }
    
    
    func enableButton() {
        todoButton.isEnabled = true
        
        laptopButon.isEnabled = true
        
        photoButton.isEnabled = true
        
        polaroidButton.isEnabled = true
        
        rubickButton.isEnabled = true
        
        glassButton.isEnabled = true
        
        piggyButton.isEnabled = true
        
        bookButton.isEnabled = true
        
        phoneButton.isEnabled = true
        
        legoButton.isEnabled = true
    }
    
}

@IBDesignable public class CornerButton: UIButton {
 

        @IBInspectable var borderWidth: CGFloat {
            set {
                layer.borderWidth = newValue
            }
            get {
                return layer.borderWidth
            }
        }

        @IBInspectable var cornerRadius: CGFloat {
            set {
                layer.cornerRadius = newValue
            }
            get {
                return layer.cornerRadius
            }
        }

        @IBInspectable var borderColor: UIColor? {
            set {
                guard let uiColor = newValue else { return }
                layer.borderColor = uiColor.cgColor
            }
            get {
                guard let color = layer.borderColor else { return nil }
                return UIColor(cgColor: color)
            }
        }
    
}


