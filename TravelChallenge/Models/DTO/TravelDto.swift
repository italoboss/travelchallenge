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
    var expenses: [ExpenseDto] = []
    
    var costValue: Double {
        var total = 0.0
        for expense in expenses {
            total += expense.costValue
        }
        return total
    }
    
    init(with destination: String, travelDate: Date, savedValue: Double) {
        self.destination = destination
        self.travelDate = travelDate
        self.savedValue = savedValue
        self.initExpenses()
    }
    
    func initExpenses() {
        expenses = []
        for expenseCase in ExpenseCategory.allCases {
            expenses.append(
                ExpenseDto(with: expenseCase, priority: expenseCase.rawValue, costValue: 0.0)
            )
        }
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
        
        if let expenses = entity.expenses as? Set<Expense> {
            for expense in expenses {
                if let add = try? ExpenseDto(from: expense) {
                    self.expenses.append(add)
                }
            }
        }
    }
    
}
