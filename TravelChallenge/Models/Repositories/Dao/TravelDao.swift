//
//  TravelDao.swift
//  TravelChallenge
//
//  Created by Italo Boss on 30/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import CoreData

class TravelDao {
    
    private var coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = CoreDataManager.manager) {
        self.coreDataManager = coreDataManager
    }
    
    func fetchMyTravel() -> Travel? {
        guard let travel: Travel = coreDataManager.fecth()?.first
            else {
                return nil
        }
        return travel
    }
    
    func fetch(by destination: String, and travelDate: Date) -> Travel? {
        let whereDestination = NSPredicate(format: "destination == %@", destination)
        let whereDate = NSPredicate(format: "travelDate == %@", travelDate as NSDate)
        guard let travel: Travel = coreDataManager.fecth(where: NSCompoundPredicate(andPredicateWithSubpredicates: [whereDestination, whereDate]))?.first else {
            return nil
        }
        return travel
    }
    
    func save(travel: TravelDto) -> Bool {
        var toSave: Travel
        if let savedTravel: Travel = fetchMyTravel() {
            toSave = savedTravel
        }
        else {
            toSave = Travel(context: coreDataManager.persistentContainer.viewContext)
        }
        toSave.destination = travel.destination
        toSave.travelDate = travel.travelDate
        toSave.savedValue = travel.savedValue
        if toSave.createdAt == nil {
            toSave.createdAt = Date()
        }
        coreDataManager.saveContext()
        
        if travel.expenses.count > 0 && !ExpenseDao().saveAll(travel.expenses, in: travel) {
            coreDataManager.delete(objects: [toSave])
            coreDataManager.saveContext()
            return false
        }
        return true
    }
    
    func update(savedValue: Double, from trip: TravelDto) -> Bool {
        if let trip = self.fetch(by: trip.destination, and: trip.travelDate) {
            trip.savedValue += savedValue
            coreDataManager.saveContext()
            return true
        }
        return false
    }
    
}
