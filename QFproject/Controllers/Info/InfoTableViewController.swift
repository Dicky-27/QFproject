//
//  InfoTableViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 19/06/21.
//

import UIKit

class InfoTableViewController: UITableViewController {
    
    var vc = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InfoTableViewCell

        if indexPath.row == 0 {
            cell.imageItem.image = #imageLiteral(resourceName: "pig")
            cell.judulItem.text = "Piggy Bank"
            cell.descItem.text = "Your character current Socioeconomic Status"
        } else if indexPath.row == 1{
            
            cell.imageItem.image = #imageLiteral(resourceName: "phoneNo")
            cell.judulItem.text = "Phone"
            cell.descItem.text = "Your character personalitys"
            
        }else if indexPath.row == 2{
            cell.imageItem.image = #imageLiteral(resourceName: "laptop")
            cell.judulItem.text = "Laptop"
            cell.descItem.text = "Character’s temperaments"
            
        }else if indexPath.row == 3{
            cell.imageItem.image = #imageLiteral(resourceName: "frame")
            cell.judulItem.text = "Photo Frame"
            cell.descItem.text = "Your character's physical details (age, gender, etc.)"
            
        }else if indexPath.row == 4{
            cell.imageItem.image = #imageLiteral(resourceName: "todo")
            cell.judulItem.text = "To do List"
            cell.descItem.text = "Daily routine of your character or his daily life"
            
        }else if indexPath.row == 5{
            cell.imageItem.image = #imageLiteral(resourceName: "Action Figure Outline")
            cell.judulItem.text = "Action Figure"
            cell.descItem.text = "Your character hobby(ies)"
            
        }else if indexPath.row == 6{
            cell.imageItem.image = #imageLiteral(resourceName: "rubik")
            cell.judulItem.text = "Rubik's Cube"
            cell.descItem.text = "How your character solve his/her problem"
            
        }else if indexPath.row == 7{
            cell.imageItem.image = #imageLiteral(resourceName: "book")
            cell.judulItem.text = "Recipe Book"
            cell.descItem.text = "Your character intellegence"
            
        }else if indexPath.row == 8{
            cell.imageItem.image = #imageLiteral(resourceName: "glass")
            cell.judulItem.text = "Glass of water"
            cell.descItem.text = "Your character perspective on life"
            
        }else{
            cell.imageItem.image = #imageLiteral(resourceName: "polaroid")
            cell.judulItem.text = "Polaroid"
            cell.descItem.text = "Significant moments or people in your character’s life"
        }

        return cell
    }
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
 

}
