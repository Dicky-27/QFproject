//
//  ImageViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 13/06/21.
//

import UIKit

import CoreData

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePhoto: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    // Age & gender
    @IBOutlet weak var ageTf: UITextField!
    
    @IBOutlet weak var male: UIButton!
    @IBOutlet weak var female: UIButton!
    
    
    // skin
    @IBOutlet weak var white: UIButton!
    @IBOutlet weak var yellow: UIButton!
    @IBOutlet weak var brown: UIButton!
    @IBOutlet weak var black: UIButton!
 
    //posture
    @IBOutlet weak var stif: UIButton!
    @IBOutlet weak var casual: UIButton!
    @IBOutlet weak var slout: UIButton!
    @IBOutlet weak var turtle: UIButton!
    
    
    //app
    @IBOutlet weak var cas: UIButton!
    @IBOutlet weak var slo: UIButton!
    @IBOutlet weak var tur: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var itemArray = [Characters]()
    
    
    var gender = ""
    var skin = ""
    var posture = ""
    var appe = ""
    
    var vc = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePhoto.layer.borderWidth = 1
        imagePhoto.layer.borderColor = UIColor(named: "ButtonColor")?.cgColor
        imagePhoto.layer.cornerRadius = 12
        
        addButton.menu = addMenuItems()
        addButton.showsMenuAsPrimaryAction = true
        
    }
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func saveImage(_ sender: UIButton) {
        
        
        guard
            let vc = presentingViewController as? WritersRoomViewController
        else {
            return
        }
        
        
        if let imageData = imagePhoto.image?.pngData() {
            
         
            let alert = UIAlertController(title: "Character Saved", message: "Your changes have been saved", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            
                
                // untuk important value
                
                CharLandingViewController.selectedChars?.setValue(imageData, forKey: "photo")
                
                CharLandingViewController.selectedChars?.setValue(self.gender, forKey: "gender")
                
                
                CharLandingViewController.selectedChars?.setValue(self.skin, forKey: "skin")
                
                CharLandingViewController.selectedChars?.setValue(self.posture, forKey: "posture")
                
                CharLandingViewController.selectedChars?.setValue(self.appe, forKey: "appearances")
                
                CharLandingViewController.selectedChars?.setValue(self.ageTf.text, forKey: "age")
                
                self.saveItems()
                
                self.dismiss(animated: true, completion: {
                    vc.alernya()
                })
            
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userPickedImage = info[.editedImage] as? UIImage else { return }
        imagePhoto.image = userPickedImage

        picker.dismiss(animated: true)
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
    
    @IBAction func gender(_ sender: UIButton) {
        

        
        if sender.tag == 0 {
            
            if male.isSelected {
                male.isSelected = false
                female.isSelected = false
                
                male.backgroundColor = UIColor.white
                female.backgroundColor = UIColor.white
                
                gender = ""
                
            }else {
                male.isSelected = true
                female.isSelected = false
                
                male.backgroundColor = UIColor(named: "ButtonColor")
                female.backgroundColor = UIColor.white
                
                gender = "Male"
            }
            
        }else {
            if female.isSelected {
                male.isSelected = false
                female.isSelected = false
                
                male.backgroundColor = UIColor.white
                female.backgroundColor = UIColor.white
                
                gender = ""
                
                
            }else {
                male.isSelected = false
                female.isSelected = true
                
                female.backgroundColor = UIColor(named: "ButtonColor")
                male.backgroundColor = UIColor.white
                
                gender = "Female"
                
            }
            
        }
        
        
    }
    
    @IBAction func skinButton(_ sender: UIButton) {
        
        if sender.tag == 0 {
    
            if white.isSelected {
                white.isSelected = false
                yellow.isSelected = false
                brown.isSelected = false
                black.isSelected = false
                
                
                white.backgroundColor = UIColor.white
                yellow.backgroundColor = UIColor.white
                brown.backgroundColor = UIColor.white
                black.backgroundColor = UIColor.white
                
                skin = ""
                
            }else {
                white.isSelected = true
                yellow.isSelected = false
                brown.isSelected = false
                black.isSelected = false
                
                white.backgroundColor = UIColor(named: "ButtonColor")
                yellow.backgroundColor = UIColor.white
                brown.backgroundColor = UIColor.white
                black.backgroundColor = UIColor.white
                
                skin = "White"
            }
            
        }else if sender.tag == 1 {
            if yellow.isSelected {
                yellow.isSelected = false
                white.isSelected = false
                brown.isSelected = false
                black.isSelected = false
                
                
                white.backgroundColor = UIColor.white
                yellow.backgroundColor = UIColor.white
                brown.backgroundColor = UIColor.white
                black.backgroundColor = UIColor.white
                
                skin = ""
                
            }else {
                yellow.isSelected = true
                white.isSelected = false
                brown.isSelected = false
                black.isSelected = false
                
                yellow.backgroundColor = UIColor(named: "ButtonColor")
                white.backgroundColor = UIColor.white
                brown.backgroundColor = UIColor.white
                black.backgroundColor = UIColor.white
                
                skin = "Yellow"
            }
            
        }else if sender.tag == 2 {
            if brown.isSelected {
                white.isSelected = false
                yellow.isSelected = false
                brown.isSelected = false
                black.isSelected = false
                
                
                white.backgroundColor = UIColor.white
                yellow.backgroundColor = UIColor.white
                brown.backgroundColor = UIColor.white
                black.backgroundColor = UIColor.white
                
                skin = ""
                
            }else {
                brown.isSelected = true
                yellow.isSelected = false
                white.isSelected = false
                black.isSelected = false
                
                brown.backgroundColor = UIColor(named: "ButtonColor")
                yellow.backgroundColor = UIColor.white
                white.backgroundColor = UIColor.white
                black.backgroundColor = UIColor.white
                
                skin = "Brown"
            }
        }else {
            if black.isSelected {
                white.isSelected = false
                yellow.isSelected = false
                brown.isSelected = false
                black.isSelected = false
                
                
                white.backgroundColor = UIColor.white
                yellow.backgroundColor = UIColor.white
                brown.backgroundColor = UIColor.white
                black.backgroundColor = UIColor.white
                
                skin = ""
                
            }else {
                black.isSelected = true
                yellow.isSelected = false
                brown.isSelected = false
                white.isSelected = false
                
                black.backgroundColor = UIColor(named: "ButtonColor")
                yellow.backgroundColor = UIColor.white
                brown.backgroundColor = UIColor.white
                white.backgroundColor = UIColor.white
                
                skin = "Black"
            }
        }
        
    }
    
    
    @IBAction func postureButton(_ sender: UIButton) {
        
        if sender.tag == 0 {
    
            if stif.isSelected {
                stif.isSelected = false
                casual.isSelected = false
                slout.isSelected = false
                turtle.isSelected = false
                
                
                stif.backgroundColor = UIColor.white
                casual.backgroundColor = UIColor.white
                slout.backgroundColor = UIColor.white
                turtle.backgroundColor = UIColor.white
                
                posture = ""
                
            }else {
                stif.isSelected = true
                casual.isSelected = false
                slout.isSelected = false
                turtle.isSelected = false
                
                stif.backgroundColor = UIColor(named: "ButtonColor")
                casual.backgroundColor = UIColor.white
                slout.backgroundColor = UIColor.white
                turtle.backgroundColor = UIColor.white
                
                posture = "Stiff & Military"
            }
            
        }else if sender.tag == 1 {
            if casual.isSelected {
                stif.isSelected = false
                casual.isSelected = false
                slout.isSelected = false
                turtle.isSelected = false
                
                
                stif.backgroundColor = UIColor.white
                casual.backgroundColor = UIColor.white
                slout.backgroundColor = UIColor.white
                turtle.backgroundColor = UIColor.white
                
                posture = ""
                
            }else {
                casual.isSelected = true
                stif.isSelected = false
                slout.isSelected = false
                turtle.isSelected = false
                
                casual.backgroundColor = UIColor(named: "ButtonColor")
                stif.backgroundColor = UIColor.white
                slout.backgroundColor = UIColor.white
                turtle.backgroundColor = UIColor.white
                
                posture = "Casual"
            }
            
        }else if sender.tag == 2 {
            if slout.isSelected {
                stif.isSelected = false
                casual.isSelected = false
                slout.isSelected = false
                turtle.isSelected = false
                
                
                stif.backgroundColor = UIColor.white
                casual.backgroundColor = UIColor.white
                slout.backgroundColor = UIColor.white
                turtle.backgroundColor = UIColor.white
                
                posture = ""
                
            }else {
                slout.isSelected = true
                casual.isSelected = false
                turtle.isSelected = false
                stif.isSelected = false
                
                slout.backgroundColor = UIColor(named: "ButtonColor")
                casual.backgroundColor = UIColor.white
                stif.backgroundColor = UIColor.white
                turtle.backgroundColor = UIColor.white
                
                posture = "Slouching"
            }
            
        }else {
            if turtle.isSelected {
                stif.isSelected = false
                casual.isSelected = false
                slout.isSelected = false
                turtle.isSelected = false
                
                
                stif.backgroundColor = UIColor.white
                casual.backgroundColor = UIColor.white
                slout.backgroundColor = UIColor.white
                turtle.backgroundColor = UIColor.white
                
                posture = ""
                
            }else {
                turtle.isSelected = true
                casual.isSelected = false
                slout.isSelected = false
                stif.isSelected = false
                
                turtle.backgroundColor = UIColor(named: "ButtonColor")
                casual.backgroundColor = UIColor.white
                slout.backgroundColor = UIColor.white
                stif.backgroundColor = UIColor.white
                
                posture = "Turtle & Tired"
            }
        }
        
    }
    
    
    @IBAction func appearanceButton(_ sender: UIButton) {
        
        if sender.tag == 0 {
    
            if cas.isSelected {
                cas.isSelected = false
                slo.isSelected = false
                tur.isSelected = false
                
                
                cas.backgroundColor = UIColor.white
                slo.backgroundColor = UIColor.white
                tur.backgroundColor = UIColor.white
                
                appe = ""
                
            }else {
                cas.isSelected = true
                slo.isSelected = false
                tur.isSelected = false
                
                cas.backgroundColor = UIColor(named: "ButtonColor")
                slo.backgroundColor = UIColor.white
                tur.backgroundColor = UIColor.white
                
                appe = "Casual"
            }
            
        }else if sender.tag == 1 {
            if slo.isSelected {
                cas.isSelected = false
                slo.isSelected = false
                tur.isSelected = false
                
                
                cas.backgroundColor = UIColor.white
                slo.backgroundColor = UIColor.white
                tur.backgroundColor = UIColor.white
                
                appe = ""
                
            }else {
                slo.isSelected = true
                cas.isSelected = false
                tur.isSelected = false
                
                slo.backgroundColor = UIColor(named: "ButtonColor")
                cas.backgroundColor = UIColor.white
                tur.backgroundColor = UIColor.white
                
                appe = "Slouching"
            }
            
        }else {
            if tur.isSelected {
                cas.isSelected = false
                slo.isSelected = false
                tur.isSelected = false
                
                
                cas.backgroundColor = UIColor.white
                slo.backgroundColor = UIColor.white
                tur.backgroundColor = UIColor.white
                
                appe = ""
                
            }else {
                tur.isSelected = true
                slo.isSelected = false
                cas.isSelected = false
                
                tur.backgroundColor = UIColor(named: "ButtonColor")
                slo.backgroundColor = UIColor.white
                cas.backgroundColor = UIColor.white
                
                appe = "Turtle & Tired"
            }
            
        }
        
    }
    
    
    
    

    
    func addMenuItems() -> UIMenu {
        let menuItems = UIMenu(title: "", options: .displayInline, children: [
            
            UIAction(title: "From Camera", image: UIImage(systemName: "camera"), handler: {
                (_) in
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
                picker.sourceType = .camera
                self.present(picker, animated: true)
                
                print(NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).last!);

                
                
            }),
            
            UIAction(title: "From Gallery", image: UIImage(systemName: "photo.fill.on.rectangle.fill"), handler: {
                (_) in
                
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
                picker.sourceType = .photoLibrary
                self.present(picker, animated: true)
                
                print(NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).last!);

                
            })
            
           
        
        ])
        
        return menuItems
    }
    
    
    
}
