//
//  TravelRepository.swift
//  TravelChallenge
//
//  Created by Italo Boss on 29/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import CoreData

class TravelRepository {
    
    func fetchMyTravel() -> Travel? {
        guard let travel: Travel = CoreDataManager.manager.fecth()?.first else {
            return nil
        }
        return travel
    }
    
    func saveTravel(to destination: String, at travelDate: Date, with savedValue: Double) {
        var travel: Travel = Travel(context: CoreDataManager.manager.persistentContainer.viewContext)
        if let savedTravel = fetchMyTravel() {
            travel = savedTravel
        }
        travel.destination = destination
        travel.travelDate = travelDate
        travel.savedValue = savedValue
        travel.createdAt = Date()
        CoreDataManager.manager.saveContext()
    }
    
}
