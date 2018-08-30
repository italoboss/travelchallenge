//
//  ExpenseRepository.swift
//  TravelChallenge
//
//  Created by Italo Boss on 29/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import CoreData

class ExpenseRepository {
    
    let dao = ExpenseDao()
    
    func fetchAll() -> [ExpenseDto]? {
        guard let expenses: [Expense] = dao.fetchAll() else {
            return nil
        }
        var expensesDto = Array<ExpenseDto>()
        for expense in expenses {
            if let new = try? ExpenseDto(from: expense) {
                expensesDto.append(new)
            }
        }
        return expensesDto
    }
    
    func fetchAll(of travel: TravelDto) -> [ExpenseDto]? {
        guard let expenses = dao.fetchAll(of: travel) else {
            return nil
        }
        var expensesDto = Array<ExpenseDto>()
        for expense in expenses {
            if let new = try? ExpenseDto(from: expense) {
                expensesDto.append(new)
            }
        }
        return expensesDto
    }
    
    func saveAll(_ expenses: [ExpenseDto], in travel: TravelDto) -> Bool {
        return dao.saveAll(expenses, in: travel)
    }
    
}
