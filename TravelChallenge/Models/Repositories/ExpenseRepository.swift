//
//  ExpenseRepository.swift
//  TravelChallenge
//
//  Created by Italo Boss on 29/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import CoreData

class ExpenseRepository {
    
    func fetchAll() -> [ExpenseDto] {
        guard let expenses: [Expense] = CoreDataManager.manager.fecth() else {
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
    
    func fetchAll(of travel: Travel) -> [ExpenseDto] {
        guard let expenses: [Expense] = CoreDataManager.manager.fecth() else {
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
    func saveAll(_ expenses: [ExpenseDto]) -> Bool {
        guard let travel: Travel = CoreDataManager.manager.fecth()?.first else {
            return false
        }
        for expense in expenses {
            guard let category = Int16(exactly: expense.category.rawValue), let priority = Int16(exactly: expense.priority) else {
                return false
            }
            let managedExpense = Expense(context: CoreDataManager.manager.persistentContainer.viewContext)
            managedExpense.category = category
            managedExpense.priority = priority
            managedExpense.costValue = expense.costValue
            managedExpense.travel = travel
        }
        CoreDataManager.manager.saveContext()
        return true
    }
    
}
