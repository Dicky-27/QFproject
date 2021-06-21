//
//  CanvasViewController.swift
//  QFproject
//
//  Created by Dicky Buwono on 19/06/21.
//

import UIKit
import PencilKit
import SpriteKit
import CoreData


class CanvasViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver, UIScreenshotServiceDelegate{

    @IBOutlet weak var canvasView: PKCanvasView!
    @IBOutlet weak var viewBelakang: UIView!
    @IBOutlet weak var viewBuatSs: UIView!
    
    @IBOutlet weak var clearCanvas: UIBarButtonItem!
    @IBOutlet weak var clearCharacter: UIBarButtonItem!
    @IBOutlet weak var addCharacter: UIBarButtonItem!
    
    @IBOutlet weak var navBar: UINavigationBar!
    var i = 0
    
    var itemArray = [Characters]()
    
    var panGesture  = UIPanGestureRecognizer()
    var toolPicker:PKToolPicker!
    
    static let canvasWidth: CGFloat = 768
    static let canvasOverscrollHeight: CGFloat = 500
    
    static var index: [Int] = []
    
    @IBOutlet weak var segementedMode: UISegmentedControl!
    static var characternya: Characters?
    
    var vc = ""
    var imageViews = [UIImageView]()
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCanvasView()
        segementedMode.selectedSegmentIndex = 0
        
        
        clearCharacter.isEnabled = false
        addCharacter.isEnabled = false
    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
       
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        setUpCanvasView()
    
        
    
    }
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let image = viewBuatSs.takeScreenshot()
         UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved(_:didFinishSavingWithError:contextType:)), nil)

//        let pdfFilePath = self.viewBuatSs.exportAsPdfFromView()
//        print(pdfFilePath)
        
        
    }
    
    private func setUpCanvasView(){
        
        if #available(iOS 14.0, *) {
            toolPicker = PKToolPicker()
        } else {
            // Set up the tool picker, using the window of our parent because our view has not
            // been added to a window yet.
            let window = parent?.view.window
            toolPicker = PKToolPicker.shared(for: window!)
        }
            
            canvasView.delegate = self
            
            toolPicker.setVisible(true, forFirstResponder: canvasView)
            toolPicker.addObserver(canvasView)
            canvasView.becomeFirstResponder()
        
            canvasView.backgroundColor = UIColor.clear
            
            
        
    }
    
    @IBAction func clearButton(_ sender: UIBarButtonItem) {
        
        canvasView.drawing = PKDrawing()
    }
    
    
    @IBAction func char(_ sender: UIBarButtonItem) {
        for v in viewBelakang.subviews {
            v.removeFromSuperview()
            
        }
    }
    
    @IBAction func segementedControll(_ sender: UISegmentedControl) {
        
        switch(sender.selectedSegmentIndex)
            {
            case 0:
                canvasView.isHidden = false
                setUpCanvasView()
                clearCharacter.isEnabled = false
                clearCanvas.isEnabled = true
                addCharacter.isEnabled = false
                break

            case 1:
                canvasView.isHidden = true
                toolPicker.setVisible(false, forFirstResponder: canvasView)
                clearCharacter.isEnabled = true
                clearCanvas.isEnabled = false
                addCharacter.isEnabled = true
                break
                
                
            default:
                break

            }
       
    }
    
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goChar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goChar" {
            if let nextVc = segue.destination as? AddCharViewController {
                nextVc.onCreate = {
                
                }
            }
        }else if segue.identifier == "goProfile" {
            if let nextVc = segue.destination as? ProfileViewController{
                nextVc.vc = ""
            }
        }
    }
    
    @IBAction func unwindToCanvas (_ sender: UIStoryboardSegue) {
        
    }
    
    
    
    
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @objc func dragView(_ sender: UIPanGestureRecognizer) {

        let point = sender.location(in: self.viewBelakang)
        let theDraggedView = sender.view!
            theDraggedView.center = point
        }
    
    
    func addGambar(imageData: Data){
        
        let gambar = UIImageView()
        
        if i == 300 {
            i = 0
        }
        
        gambar.image = UIImage(data: imageData)
        gambar.frame = CGRect(x: 200 + i, y: 200 + i, width: 150, height: 150)
        gambar.layer.cornerRadius = 12
        gambar.layer.borderColor = UIColor(named: "ButtonColor")?.cgColor
        gambar.layer.borderWidth = 1
        gambar.layer.masksToBounds = true
        
        self.viewBelakang.addSubview(gambar)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(dragView))
        gambar.addGestureRecognizer(gesture)
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,   action: #selector(tapped(sender:)))
        tapGestureRecognizer.numberOfTapsRequired = 2
        gambar.addGestureRecognizer(tapGestureRecognizer)
        
       
        
        gambar.isUserInteractionEnabled = true
    
        i += 50
        
        
        
    }
    
    @objc func tapped(sender: UITapGestureRecognizer)
    {
        
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController

        secondViewController.chek = true
        
        secondViewController.modalPresentationStyle = .fullScreen
        present(secondViewController, animated: true, completion: nil)
        
        
    }
    
    
    
    @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: Error?, contextType: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    

}

extension UIView {

    func takeScreenshot() -> UIImage {

        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)

        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
}
