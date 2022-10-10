//
//  DBOps.swift
//  iTunes Client App
//
//  Created by Emiralp Duman on 10.10.2022.
//

import UIKit
import CoreData

final class DBOps {
    static let shared = DBOps()
    
    private var appDelegate: AppDelegate {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate not found.")
        }
        return delegate
    }
    
    private var managedContext: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    // Create
    func create(entityName: String, values: [String : Any], completion: (NSManagedObject?, Error?) -> Void) {
        let entity = NSEntityDescription.entity(forEntityName: entityName,
                                                in: managedContext)
        
        let object = NSManagedObject(entity: entity!,
                                     insertInto: managedContext)
        for (key, value) in values {
            object.setValue(value, forKey: key)
        }
        
        do {
            try managedContext.save()
            completion(object, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    // Read
    func read(completion: ([NSManagedObject]?, Error?) -> Void) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            completion(objects, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    // Update
    func update() {
        print("update")
    }
    
    // Delete
    func delete(entityName: String, object: NSManagedObject, completion: (Error?) -> Void) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            let tempItems = try managedContext.fetch(fetchRequest)
            
            for tempItem in tempItems where tempItem == object {
                managedContext.delete(tempItem)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        do {
            try managedContext.save()
            completion(nil)
        } catch {
            completion(error)
        }
    }
}
