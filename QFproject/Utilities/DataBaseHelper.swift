//
//  DataBaseHelper.swift
//  Saving Image in Core Data
//
//  Created by Amol Rai on 07/12/19.
//  Copyright © 2019 Amit Rai. All rights reserved.
//

import UIKit
import CoreData

class DataBaseHelper {
    
    static let shareInstance = DataBaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveImage(data: Data) {
        let imageInstance = Characters(context: context)
        imageInstance.photo = data
            
        do {
            try context.save()
            print("Image is saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage() -> [Characters] {
        var fetchingImage = [Characters]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Characters")
        
        do {
            fetchingImage = try context.fetch(fetchRequest) as! [Characters]
        } catch {
            print("Error while fetching the image")
        }
        
        return fetchingImage
    }
}
