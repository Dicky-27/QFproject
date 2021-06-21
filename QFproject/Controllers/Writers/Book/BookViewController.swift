//
//  GlassViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 12/06/21.
//

import UIKit

class BookViewController: UIViewController {

   
    @IBOutlet weak var pil1: UIButton!
    @IBOutlet weak var pil2: UIButton!
    
    @IBOutlet weak var gambarItem: UIImageView!
    
    @IBOutlet weak var pertanyaan: UILabel!
    
    
    let allQuestions = QuestionBank()
    var questionNumber: Int = 0
    
    var a  = 0
    var b = 0
    
    var vc = ""
    
    var nilai: [Int] = [0,0]
    var hasil = ""

    var smart: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gambarItem.image = #imageLiteral(resourceName: "Question Intelligence")
        
        pil1.layer.borderWidth = 1
        pil1.layer.cornerRadius = 12
        
        pil1.layer.borderColor = UIColor(named: "ButtonColor")?.cgColor
        
        pil2.layer.borderWidth = 1
        pil2.layer.cornerRadius = 12
        
        pil2.layer.borderColor = UIColor(named: "ButtonColor")?.cgColor
        // Do any additional setup after loading the view.
        
        
       
       
    }
   
    @IBAction func nextButton(_ sender: UIBarButtonItem) {
        
        
    }
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goSmart" {
            if let nextVC = segue.destination as? SmartViewController {
                if smart == false {
                    nextVC.checkSmart = false
                }
            }
        }
    }
    
    @IBAction func awnserButton(_ sender: UIButton) {
        
        print(sender.tag)
        
        if sender.tag == 0 {

            a += 1
           
            
            
        }else {
            b += 1
            
           
        }
        
        questionNumber += 1
        updateQuestion()
       
        
        
    }
    
    
    func nextQuestion() {
        
       
    }
    
    func updateQuestion(){
        
        if questionNumber <= allQuestions.list.count - 1{
            gambarItem.image = UIImage(named:(allQuestions.list[questionNumber].questionImage))
            pertanyaan.text = allQuestions.list[questionNumber].question
            pil1.setTitle(allQuestions.list[questionNumber].optionA, for: UIControl.State.normal)
            pil2.setTitle(allQuestions.list[questionNumber].optionB, for: UIControl.State.normal)

            updateUI()
            
        }else {
            
            result()
            performSegue(withIdentifier: "goSmart", sender: self)
        }
        
        
    }
    
    func result(){
    
            if a > b {
                hasil = "Book Smart"
                smart = true
            } else {
                hasil = "Street Smart"
                smart = false
            }
            
    
        print(hasil)
        
    }
    
    func updateUI(){
        
//       // scoreLabel.text = hasil
//        questionCounter.text = "\(questionNumber + 1)/\(allQuestions.list.count)"
//        progressView.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.list.count)) * CGFloat(questionNumber + 1)
        
    }
    
    func restartQuiz(){
        a = 0
        b = 0
        questionNumber = 0
        updateQuestion()
        
    }
    
    
    @IBAction func unwindToQuiz (_ sender: UIStoryboardSegue) {
        restartQuiz()
    }
    
    
}
