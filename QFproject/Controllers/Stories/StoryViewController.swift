//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Angela Yu on 01/12/2017.
//  Copyright © 2017 Angela Yu. All rights reserved.
//

import UIKit
import CoreData


class StoryTableViewController: UITableViewController{
    

    var story = [Stories]()
    private var rowDefaultSelected: Int = 0
  //  let indexFirst = NSIndexPath(row: 0, section: 0)
    
    
    
    @IBOutlet weak var toolBarButton: UIBarButtonItem!
    

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadStories()
        
        
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
    
       
        
//        let modalController = NewStoryViewController()
//        modalController.isDismissed = { [weak self] in
//            self?.loadStories()
//        }
        
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        loadStories()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadStories()
    }

   
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return story.count
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! StoryTableViewCell
        cell.titleLbl.text = story[indexPath.row].title
        cell.selectionStyle = .none
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            context.delete(story[indexPath.row])
            story.remove(at: indexPath.row)
            
           
            saveStories()
            
        }
    }
    

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == rowDefaultSelected {
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                rowDefaultSelected = -1
            }
    }
    

        
        // Set the spacing between sections
    

    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToChar", sender: self)
      
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if let indexPath = tableView.indexPathForSelectedRow {
                    
                let char = story[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! CharViewController
                CharViewController.selectedStory = char
                controller.judul = char.title ?? ""
                controller.premis = char.premis ?? ""
                controller.check = 1
            
                splitViewController?.showDetailViewController(controller, sender: self)
                
        }
    
    }
    //MARK: - Data Manipulation Methods
    
    func saveStories() {
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadStories() {
        
        let request : NSFetchRequest<Stories> = Stories.fetchRequest()
        
        do{
            story = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }
       
        tableView.reloadData()
        
    }
    
    
    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "NewStoryViewController") as! NewStoryViewController
        secondViewController.modalPresentationStyle = .formSheet
        secondViewController.onCreate = {
            self.loadStories()
        }
        //self.present(secondViewController, animated: true, completion: nil)
        
        let navBarOnModal: UINavigationController = UINavigationController(rootViewController: secondViewController)
        self.present(navBarOnModal, animated: true, completion: nil)

        
        
    }
    
    
}
