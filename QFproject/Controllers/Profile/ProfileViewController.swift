//
//  ProfileViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 10/06/21.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    @IBOutlet weak var segmenProfile: UISegmentedControl!
    @IBOutlet weak var tableProfile: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var charNameProfile: UILabel!
    
    @IBOutlet weak var wantsTv: UITextView!
    @IBOutlet weak var needsTv: UITextView!
    @IBOutlet weak var goalsTv: UITextView!
    @IBOutlet weak var obsTv: UITextView!
    @IBOutlet weak var backButton: UIButton!
    
    
   // var selected: Stories?
    var itemArray = [Characters]()
   // var index = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var vc = ""
    
    var name = ""
    var needs = ""
    var goals = ""
    var wants = ""
    var obs = ""
    var fisikInfo = ""
    var appeDesc = ""
    
    var chek: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableProfile.separatorStyle = .none
        splitViewController?.preferredDisplayMode = .secondaryOnly
        loadItems()
        
        
        let add = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addTapped))

        navigationItem.rightBarButtonItems = [add]
        
        if chek == false {
            backButton.isHidden = true
            backButton.isEnabled = false
        }else {
            
                backButton.isHidden = false
                backButton.isEnabled = true
        }
        
        
    }
    
    @objc func addTapped() {
        
        let alert = UIAlertController(title: "Character Saved", message: "Your changes have been saved", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default) { (action) in
        
            
    }
    
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if CharLandingViewController.newItem == true {
            
            charNameProfile.text = name
            if CharLandingViewController.itemArray.last?.photo != nil {
                imgProfile.image = UIImage(data: (CharLandingViewController.itemArray.last?.photo)!)
            } else {
                imgProfile.image = UIImage(named: "orang")
            }
            wantsTv.text = CharLandingViewController.itemArray.last?.wants
            needsTv.text = CharLandingViewController.itemArray.last?.needs
            goalsTv.text = CharLandingViewController.itemArray.last?.goals
            obsTv.text = CharLandingViewController.itemArray.last?.obstacles
            
            
        
            
        }else {
            
            charNameProfile.text = CharLandingViewController.selectedChars?.name
            if CharLandingViewController.selectedChars?.photo == nil {
                imgProfile.image = UIImage(named: "orang")
            } else {
                imgProfile.image = UIImage(data: (CharLandingViewController.selectedChars?.photo)!)
            }
            wantsTv.text = CharLandingViewController.selectedChars?.wants
            needsTv.text = CharLandingViewController.selectedChars?.needs
            goalsTv.text = CharLandingViewController.selectedChars?.goals
            obsTv.text = CharLandingViewController.selectedChars?.obstacles
            
        }
        
        imgProfile.layer.cornerRadius = 12
        imgProfile.layer.borderColor = UIColor(named: "ButtonColor")?.cgColor
        imgProfile.layer.borderWidth = 1
    }
    
    @IBAction func segmenValue(_ sender: UISegmentedControl) {
  
        switch(segmenProfile.selectedSegmentIndex)
            {
            case 0:
                tableProfile.reloadData()
                break

            case 1:
                tableProfile.reloadData()
                break
                
            case 2:
                tableProfile.reloadData()
                break
                
            default:
                break

            }
        
    }
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0

           switch(segmenProfile.selectedSegmentIndex)
           {
           case 0:
               returnValue = 1
               break
           case 1:
               returnValue = 1
               break
            
           case 2:
                returnValue = 1
           default:
               break

           }

           return returnValue
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var returnValue = 0

           switch(segmenProfile.selectedSegmentIndex)
           {
           case 0:
               returnValue = 4
               break
           case 1:
               returnValue = 8
               break
            
           case 2:
                returnValue = 7
           default:
               break

           }

           return returnValue
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      
           switch(segmenProfile.selectedSegmentIndex)
           {
           case 0:
            if section == 0 {
                return "Phyisical Aspects"
            }else if section == 1 {
                return "Appearances"
            }else if section == 2 {
                return "Posture"
            }else {
                return "Additional Info"
            }
            
           case 1:
            if section == 0 {
                return "Tempraments"
            }else if section == 1 {
                return "Strength"
            }else if section == 2 {
                return "Weakness"
            }else if section == 3{
                return "How the character see the world"
            }else if section == 4{
                return "Intelligence"
            }else if section == 5{
                return "Personality"
            }else if section == 6{
                return "Like or Dislike"
            }else {
                return "Additional Info"
            }
            
           case 2:
            if section == 0 {
                return "Economic Class"
            }else if section == 1 {
                return "Significant Momment"
            }else if section == 2 {
                return "Important Person"
            }else if section == 3{
                return "Routines"
            }else if section == 4{
                return "Hobby"
            }else if section == 5{
                return "Belief"
            }else {
                return "Additional Info"
            }
           default:
               break

           }
        
        return "header lain"
        
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = .white
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.black
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if CharLandingViewController.newItem == false {
            if let indexPaths = tableProfile.indexPathsForVisibleRows {
                for indexPath in indexPaths {
                    if let cellTiga = tableProfile?.cellForRow(at: indexPath) as? ThreeTableViewCell {
                        CharLandingViewController.selectedChars?.setValue(cellTiga.kontenTf.text, forKey: "physicalDesc")
                        
                    }
                }
                
            }
            
        }else{
            if let indexPaths = tableProfile.indexPathsForVisibleRows {
                for indexPath in indexPaths {
                    if let cellTiga = tableProfile?.cellForRow(at: indexPath) as? ThreeTableViewCell {
                        CharLandingViewController.itemArray.last?.setValue(cellTiga.kontenTf.text, forKey: "physicalDesc")
                        
                    }
                }
                
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! OneTableViewCell
        let cellDua = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! TwoTableViewCell
        let cellTiga = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! ThreeTableViewCell
        
        switch(segmenProfile.selectedSegmentIndex)
        {
        case 0:
            
            
            if CharLandingViewController.newItem == false && chek == false {
                
                if indexPath.section == 0 {
                    
                    cellTiga.kontenLbl1.text = CharLandingViewController.selectedChars?.gender ?? "Gender"
                    
                    cellTiga.kontenLbl2.text = CharLandingViewController.selectedChars?.age ?? "Age"
                    
                    cellTiga.kontenLbl3.text = CharLandingViewController.selectedChars?.skin ?? "Skin"
                    
                    cellTiga.kontenTf.placeholder = "Write more info here"
                    cellTiga.kontenTf.text = CharLandingViewController.selectedChars?.physicalDesc ?? ""
                    cellTiga.kontenTf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                    
                    return cellTiga
                } else if indexPath.section == 1 {
                    
                    cell.kontenLbl.text = CharLandingViewController.selectedChars?.appearances ?? "Appearance"
                    cell.kontenTf.placeholder = "Write more info here"
                    cell.kontenTf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                    
                    return cell
                } else if indexPath.section == 2 {
                    
                    cell.kontenLbl.text = CharLandingViewController.selectedChars?.posture ?? "Posture"
                    cell.kontenTf.placeholder = "Write more info here"
                    
                    return cell
                }else {
                    cellDua.kontenTf.placeholder = "Write more info here"
                    
                    return cellDua
                }
                
            }else {
                if indexPath.section == 0 {
                    
                    cellTiga.kontenLbl1.text = CharLandingViewController.itemArray.last?.gender ?? "Gender"
                    
                    cellTiga.kontenLbl2.text = CharLandingViewController.itemArray.last?.age ?? "Age"
                    
                    cellTiga.kontenLbl3.text = CharLandingViewController.itemArray.last?.skin ?? "Skin"
                    
                    cellTiga.kontenTf.placeholder = "Write more info here"
                    cellTiga.kontenTf.text = CharLandingViewController.itemArray.last?.physicalDesc ?? ""
                    cellTiga.kontenTf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                    
                    return cellTiga
                } else if indexPath.section == 1 {
                    
                    cell.kontenLbl.text = CharLandingViewController.itemArray.last?.appearances ?? "Appearance"
                    cell.kontenTf.placeholder = "Write more info here"
                    
                    return cell
                } else if indexPath.section == 2 {
                    
                    cell.kontenLbl.text = CharLandingViewController.itemArray.last?.posture ?? "Posture"
                    cell.kontenTf.placeholder = "Write more info here"
                    
                    return cell
                }else {
                    cellDua.kontenTf.placeholder = "Write more info here"
                    
                    return cellDua
                }
                
            }
          
            
        case 1:
            
            if CharLandingViewController.newItem == false {
                
                if indexPath.section == 0 {
                    
                    cell.kontenLbl.text = CharLandingViewController.selectedChars?.temprament ?? "Temprament"
                    cell.kontenTf.placeholder = "Write more info here"
                    
                    return cell
                    
                }else if indexPath.section == 1 {
                    cellDua.kontenTf.text = CharLandingViewController.selectedChars?.strengh
                    cellDua.kontenTf.placeholder =  "Write more info here"
                
                    return cellDua
                    
                }else if indexPath.section == 2 {
                    cellDua.kontenTf.text = CharLandingViewController.selectedChars?.weakness
                    cellDua.kontenTf.placeholder =  "Write more info here"
                    
                    return cellDua
                    
                }else if indexPath.section == 3 {
                    cell.kontenLbl.text = CharLandingViewController.selectedChars?.community ?? "Community"
                    cell.kontenTf.placeholder = "Write more info here"
                    
                    return cell
                }else if indexPath.section == 4 {
                    cell.kontenLbl.text = CharLandingViewController.selectedChars?.intelligence ?? "Intelligence"
                    cell.kontenTf.placeholder = "Write more info here"
                    
                    return cell
                }else if indexPath.section == 5 {
                    cell.kontenLbl.text = CharLandingViewController.selectedChars?.personality ?? "Personality"
                    cell.kontenTf.placeholder = "Write more info here"
                    
                    return cell
                    
                }else if indexPath.section == 6 {
                    cell.kontenLbl.text = CharLandingViewController.selectedChars?.perspective ?? "Perspective"
                    cell.kontenTf.placeholder = "Write more info here"
                    
                    return cell
                }else {
                    cellDua.kontenTf.placeholder = "Write more info here"
                    
                    return cellDua
                }
               
                
                
            }else {
                
                if indexPath.section == 0 {
                    
                    cell.kontenLbl.text = CharLandingViewController.itemArray.last?.temprament ?? "Temprament"
                    cell.kontenTf.placeholder = "Write more info here"
                    
                    return cell
                    
                }else if indexPath.section == 1 {
                    cellDua.kontenTf.text = CharLandingViewController.itemArray.last?.strengh
                    cellDua.kontenTf.placeholder =  "Write more info here"
                
                    return cellDua
                    
                }else if indexPath.section == 2 {
                    cellDua.kontenTf.text = CharLandingViewController.itemArray.last?.weakness
                    cellDua.kontenTf.placeholder =  "Write more info here"
                    
                    return cellDua
                    
                }else if indexPath.section == 3 {
                    cell.kontenLbl.text = CharLandingViewController.itemArray.last?.community ?? "Community"
                    cell.kontenTf.placeholder = "Write more info here"
                    
                    return cell
                }else if indexPath.section == 4 {
                    cell.kontenLbl.text = CharLandingViewController.itemArray.last?.intelligence ?? "Intelligence"
                    cell.kontenTf.placeholder = "Write more info here"
                    
                    return cell
                }else if indexPath.section == 5 {
                    cell.kontenLbl.text = CharLandingViewController.itemArray.last?.personality ?? "Personality"
                    cell.kontenTf.placeholder = "Write more info here"
                    
                    return cell
                    
                }else if indexPath.section == 6 {
                    cell.kontenLbl.text = CharLandingViewController.itemArray.last?.perspective ?? "Problem Solving"
                    cell.kontenTf.placeholder = "Write more info here"
                    
                    return cell
                }else {
                    cellDua.kontenTf.placeholder = "Write more info here"
                    
                    return cellDua
                }
               
                
            }
            
            
    
         
        case 2:
            
           if CharLandingViewController.newItem == false || chek == true{
                if indexPath.section == 0 {
                    
                    cell.kontenLbl.text = CharLandingViewController.selectedChars?.economiClass ?? "Economic Class"
                    cell.kontenTf.placeholder = "Write more info here"
                    
                    return cell
                    
                }else if indexPath.section == 1 {
                    cellDua.kontenTf.text = CharLandingViewController.selectedChars?.significantMoment ?? "Significant Moment"
                
                    return cellDua
                    
                }else if indexPath.section == 2 {
                    cellDua.kontenTf.text = CharLandingViewController.selectedChars?.significantPerson ?? "Important Person"
                    
                    return cellDua
                    
                }else if indexPath.section == 3 {
                    cellDua.kontenTf.text = CharLandingViewController.selectedChars?.routines ?? "Routine"
                    
                    return cellDua
                }else if indexPath.section == 4 {
                    cellDua.kontenTf.text = CharLandingViewController.selectedChars?.hobby ?? "Hobby"
                    
                    return cellDua
                }else if indexPath.section == 5 {
                    cellDua.kontenTf.text = CharLandingViewController.selectedChars?.belief ?? "Belief"
                    
                    return cellDua
                    
                }else {
                    cellDua.kontenTf.placeholder = "Write more info here"
                    
                    return cellDua
                }
                
                
           }else {
                if indexPath.section == 0 {
                    
                    cell.kontenLbl.text = CharLandingViewController.itemArray.last?.economiClass ?? "Economic CLass"
                    cell.kontenTf.placeholder = "Write more info here"
                    
                    return cell
                    
                }else if indexPath.section == 1 {
                    cellDua.kontenTf.text = CharLandingViewController.itemArray.last?.significantMoment ?? "Significant Moment"
                
                    return cellDua
                    
                }else if indexPath.section == 2 {
                    cellDua.kontenTf.text = CharLandingViewController.itemArray.last?.significantPerson ?? "Important Person"
                    
                    return cellDua
                    
                }else if indexPath.section == 3 {
                    cellDua.kontenTf.text = CharLandingViewController.itemArray.last?.important ?? "Important Status"
                    
                    return cellDua
                }else if indexPath.section == 4 {
                    cellDua.kontenTf.text = CharLandingViewController.itemArray.last?.routines ?? "Routine"
                    
                    return cellDua
                }else if indexPath.section == 5 {
                    cellDua.kontenTf.text = CharLandingViewController.itemArray.last?.hobby ?? "Hobby"
                    
                    return cellDua
                    
                }else {
                    cellDua.kontenTf.placeholder = "Write more info here"
                    
                    return cellDua
                }
                
            
           }
          
           
        default:
            break

        }
        
        
        return cell
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



