//
//  EditExpensesDelegate.swift
//  TravelChallenge
//
//  Created by Italo Boss on 05/09/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

protocol EditExpensesDelegate {
    
    func getTripToUpdate() -> TravelDto?
    func didFinished(trip: TravelDto)
    
}
