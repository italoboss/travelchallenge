//
//  TravelRepository.swift
//  TravelChallenge
//
//  Created by Italo Boss on 29/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import CoreData

class TravelRepository {
    
    let dao = TravelDao()
    
    func getMyTravel() -> TravelDto? {
        guard let savedTravel: Travel = dao.fetchMyTravel(), let travel = try? TravelDto(from: savedTravel)
        else {
            return nil
        }
        return travel
    }
    
    func save(travel: TravelDto) -> Bool {
        return dao.save(travel: travel)
    }
    
    func update(savedValue: Double, from trip: TravelDto) -> Bool {
        return dao.update(savedValue: savedValue, from: trip)
    }
    
}
