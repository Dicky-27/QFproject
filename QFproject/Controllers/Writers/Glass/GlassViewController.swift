//
//  GlassViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 14/06/21.
//

import UIKit

class GlassViewController: UIViewController {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var satu: UIButton!
    @IBOutlet weak var dua: UIButton!
    @IBOutlet weak var tiga: UIButton!
    
    var cek = 1
    var vc = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        appearance()
        
        
    }
    
    @IBAction func nextButton(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "goEco", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goEco" {
            if let nextVC = segue.destination as? CommunityViewController {
                nextVC.check = cek
                nextVC.cekSegue = true
            }
        }
    }
    

    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pilihanSatu(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            dua.isSelected = false
            tiga.isSelected = false
            
            satu.backgroundColor = UIColor.white
            dua.backgroundColor = UIColor.white
            tiga.backgroundColor = UIColor.white
            
            
        }else {
            sender.isSelected = true
            dua.isSelected = false
            tiga.isSelected = false
            
            satu.backgroundColor = UIColor(named: "ButtonColor")
            dua.backgroundColor = UIColor.white
            tiga.backgroundColor = UIColor.white
            
            cek = 1
        }
        
    }
    
    @IBAction func pilihanDua(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            satu.isSelected = false
            tiga.isSelected = false
            
            satu.backgroundColor = UIColor.white
            dua.backgroundColor = UIColor.white
            tiga.backgroundColor = UIColor.white
            
            
        }else {
            sender.isSelected = true
            satu.isSelected = false
            tiga.isSelected = false
            
            dua.backgroundColor = UIColor(named: "ButtonColor")
            satu.backgroundColor = UIColor.white
            tiga.backgroundColor = UIColor.white
            
            cek = 2
        }
        
    }
    
    @IBAction func pilihanTiga(_ sender: UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
            dua.isSelected = false
            satu.isSelected = false
            
            satu.backgroundColor = UIColor.white
            dua.backgroundColor = UIColor.white
            tiga.backgroundColor = UIColor.white
            
            
        }else {
            sender.isSelected = true
            dua.isSelected = false
            satu.isSelected = false
            
            tiga.backgroundColor = UIColor(named: "ButtonColor")
            dua.backgroundColor = UIColor.white
            satu.backgroundColor = UIColor.white
            
            cek = 3
        }
    }
    
    
    func appearance() {
        satu.layer.cornerRadius = 12
        satu.layer.borderWidth = 1
        satu.layer.borderColor = UIColor(named: "ButtonColor")?.cgColor
        
        dua.layer.cornerRadius = 12
        dua.layer.borderWidth = 1
        dua.layer.borderColor = UIColor(named: "ButtonColor")?.cgColor
        
        tiga.layer.cornerRadius = 12
        tiga.layer.borderWidth = 1
        tiga.layer.borderColor = UIColor(named: "ButtonColor")?.cgColor
    }
    
    @IBAction func unwindToGlass(_ sender: UIStoryboardSegue){
        
    }
}
