//
//  ExpenseDto.swift
//  TravelChallenge
//
//  Created by Italo Boss on 29/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import Foundation

class ExpenseDto {
    
    var category: ExpenseCategory
    var priority: Int
    var costValue: Double
    
    init(with category: ExpenseCategory, priority: Int, costValue: Double) {
        self.category = category
        self.priority = priority
        self.costValue = costValue
    }
    
    init(from entity: Expense) throws {
        let rawValue = Int(entity.category)
        guard let category = ExpenseCategory(rawValue: rawValue) else {
            // Melhorar lancamento de Erro
            throw ConverterError.fromEntityToDto
        }
        self.category = category
        self.priority = Int(entity.priority)
        self.costValue = entity.costValue
    }
    
}
