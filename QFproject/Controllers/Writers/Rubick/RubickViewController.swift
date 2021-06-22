//
//  RubickViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 16/06/21.
//

import UIKit

class RubickViewController: UIViewController {

    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var a: UIButton!
    @IBOutlet weak var b: UIButton!
    @IBOutlet weak var c: UIButton!
    @IBOutlet weak var d: UIButton!
    @IBOutlet weak var e: UIButton!
    

    
    var a1 = 0
    var b1 = 0
    var c1 = 0
    var d1 = 0
    var e1 = 0
    var vc = ""
    
    let allQuestions = QuestionBankRubick()
    var questionNumber: Int = 0
    
    var hasil = 0
    
    var nilai: [Int] = [0,0,0,0,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func jawaban(_ sender: UIButton) {
        

        
        if sender.tag == 0 {

            a1 += 1
           
            
        }else if sender.tag == 1{
            b1 += 1
            
        }else if sender.tag == 2 {
            c1 += 1
        }else if sender.tag == 3 {
            d1 += 1
        }else {
            e1 += 1
        }
        
        questionNumber += 1
        updateQuestion()
       
    }
    
    func updateQuestion(){
        
        if questionNumber <= allQuestions.list2.count - 1{
            image.image = UIImage(named:(allQuestions.list2[questionNumber].questionImage))
            question.text = allQuestions.list2[questionNumber].question
            a.setTitle(allQuestions.list2[questionNumber].optionA, for: UIControl.State.normal)
            b.setTitle(allQuestions.list2[questionNumber].optionB, for: UIControl.State.normal)
            c.setTitle(allQuestions.list2[questionNumber].optionC, for: UIControl.State.normal)
            d.setTitle(allQuestions.list2[questionNumber].optionD, for: UIControl.State.normal)
            e.setTitle(allQuestions.list2[questionNumber].optionE, for: UIControl.State.normal)
            

            updateUI()
            
        }else {
            
            result()
            performSegue(withIdentifier: "goCek", sender: self)
        }
        
        
    }
    
    func result(){
    
        nilai[0] = a1
        nilai[1] = b1
        nilai[2] = c1
        nilai[3] = d1
        nilai[4] = e1
        
        nilai.sort()
        
        if nilai.max() != nilai[2]{
            if a1 == nilai.max() {
                hasil =  0
                
            } else if b1 == nilai.max() {
                
                hasil =  1
            } else if c1 == nilai.max() {
                
                hasil = 2
            } else if d1 == nilai.max(){
                
                hasil = 3
            }else if e1 == nilai.max(){
                hasil = 4
            }else {
                hasil = 5
            }
           
        }else {
            hasil = 5
        }
        
        
    }
    
    func updateUI(){
        
        
    }
    
    func restartQuiz(){
        a1 = 0
        b1 = 0
        c1 = 0
        d1 = 0
        e1 = 0
        questionNumber = 0
        updateQuestion()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goCek" {
            if let nextVC = segue.destination as? IntelViewController {
                nextVC.cek = hasil
            }
        }
    }
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func unwindToRubick (_ sender: UIStoryboardSegue) {
        restartQuiz()
    }
    
}
