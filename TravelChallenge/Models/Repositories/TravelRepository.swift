//
//  TravelRepository.swift
//  TravelChallenge
//
//  Created by Italo Boss on 29/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import CoreData

class TravelRepository {
    
    func fetchMyTravel() -> TravelDto? {
        guard let savedTravel: Travel = CoreDataManager.manager.fecth()?.first, let travel =  try? TravelDto(from: savedTravel)
        else {
            return nil
        }
        
        return travel
    }
    
    func save(travel: TravelDto) {
        var toSave: Travel = Travel(context: CoreDataManager.manager.persistentContainer.viewContext)
        if let savedTravel: Travel = CoreDataManager.manager.fecth()?.first {
            toSave = savedTravel
        }
        toSave.destination = travel.destination
        toSave.travelDate = travel.travelDate
        toSave.savedValue = travel.savedValue
        toSave.createdAt = Date()
        CoreDataManager.manager.saveContext()
    }
    
}
