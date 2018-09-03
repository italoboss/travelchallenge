//
//  TravelDao.swift
//  TravelChallenge
//
//  Created by Italo Boss on 30/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import CoreData

class TravelDao {
    
    func fetchMyTravel() -> Travel? {
        guard let travel: Travel = CoreDataManager.manager.fecth()?.first
            else {
                return nil
        }
        return travel
    }
    
    func fetch(by destination: String, and travelDate: Date) -> Travel? {
        let whereDestination = NSPredicate(format: "destination == %@", destination)
        let whereDate = NSPredicate(format: "travelDate == %@", travelDate as NSDate)
        guard let travel: Travel = CoreDataManager.manager.fecth(where: NSCompoundPredicate(andPredicateWithSubpredicates: [whereDestination, whereDate]))?.first else {
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
            toSave = Travel(context: CoreDataManager.manager.persistentContainer.viewContext)
        }
        toSave.destination = travel.destination
        toSave.travelDate = travel.travelDate
        toSave.savedValue = travel.savedValue
        toSave.createdAt = Date()
        CoreDataManager.manager.saveContext()
        return true
    }
    
    func update(savedValue: Double, from trip: TravelDto) -> Bool {
        if let trip = self.fetch(by: trip.destination, and: trip.travelDate) {
            trip.savedValue += savedValue
            CoreDataManager.manager.saveContext()
            return true
        }
        return false
    }
    
}
