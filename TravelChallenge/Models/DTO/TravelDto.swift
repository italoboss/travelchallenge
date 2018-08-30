//
//  TravelDto.swift
//  TravelChallenge
//
//  Created by Italo Boss on 29/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import Foundation

class TravelDto {
    var destination: String
    var travelDate: Date
    var savedValue: Double
    var createdAt: Date?
    var costValue: Double?
    
    init(with destination: String, travelDate: Date, savedValue: Double) {
        self.destination = destination
        self.travelDate = travelDate
        self.savedValue = savedValue
    }
    
    init(from entity: Travel) throws {
        guard let destination = entity.destination, let createdAt = entity.createdAt, let travelDate = entity.travelDate
        else {
            // Melhorar lancamento de Erro
            throw ConverterError.fromEntityToDto
        }
        self.destination = destination
        self.travelDate = travelDate
        self.savedValue = entity.savedValue
        self.createdAt = createdAt
        
        var costValue = 0.0
        if let expenses = entity.expenses as? Set<Expense> {
            for expense in expenses {
                costValue += expense.costValue
            }
        }
        self.costValue = costValue
    }
    
}
