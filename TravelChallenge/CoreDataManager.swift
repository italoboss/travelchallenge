//
//  CoreDataManager.swift
//  TravelChallenge
//
//  Created by Italo Boss on 28/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let manager = CoreDataManager()
    private var storeType: String? = nil
    
    private init() { }
    
    init(type: String = NSSQLiteStoreType) {
        self.storeType = type
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TravelChallenge")
        if let storeType = self.storeType {
            let description = container.persistentStoreDescriptions.first
            description?.type = storeType
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                ErrorHandler.printErrorMessage(error: error)
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                ErrorHandler.printErrorMessage(error: nserror)
            }
        }
    }
    
    func fecth<T: NSManagedObject>(where predicates: NSCompoundPredicate? = nil, sorting sorters: [NSSortDescriptor]? = nil) -> [T]? {
        let context = persistentContainer.viewContext
        let entityName = String(describing: T.self)
        let request = NSFetchRequest<T>(entityName: entityName)
        if let conditions = predicates {
            request.predicate = conditions
        }
        if let sortDescriptors = sorters {
            request.sortDescriptors = sortDescriptors
        }
        
        do {
            let records = try context.fetch(request)
            return records
        } catch {
            let nserror = error as NSError
            ErrorHandler.printErrorMessage(error: nserror)
            return nil
        }
    }
    
    func delete<T: NSManagedObject>(objects: [T]) {
        for obj in objects {
            persistentContainer.viewContext.delete(obj)
        }
    }

}
