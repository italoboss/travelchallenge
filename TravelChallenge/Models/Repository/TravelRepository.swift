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
        guard let travel: Travel = CoreDataManager.manager.fecth(where: nil, sorting: nil)?.first else {
            return nil
        }
        return travel
    }
    
    func saveNewTravel(to destination: String, at travelDate: Date, with savedValue: Double) {
        
        let travel = Travel(context: CoreDataManager.manager.persistentContainer.viewContext)
        travel.destination = destination
        travel.travelDate = travelDate
        travel.savedValue = savedValue
        
        CoreDataManager.manager.saveContext()
    }
    
}
