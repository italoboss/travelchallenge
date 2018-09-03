//
//  AddOrEditTripDelegate.swift
//  TravelChallenge
//
//  Created by Italo Boss on 03/09/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

protocol AddOrEditTripDelegate {
    
    func getTripToUpdate() -> TravelDto?
    func didSave(trip: TravelDto)
    
}
