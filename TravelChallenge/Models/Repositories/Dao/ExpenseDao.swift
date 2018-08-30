//
//  ExpenseDao.swift
//  TravelChallenge
//
//  Created by Italo Boss on 30/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import CoreData

class ExpenseDao {
    
    func fetchAll() -> [Expense]? {
        guard let expenses: [Expense] = CoreDataManager.manager.fecth() else {
            return nil
        }
        return expenses
    }
    
    func fetchAll(of travel: TravelDto) -> [Expense]? {
        guard let savedTravel: Travel = TravelDao().fetch(by: travel.destination, and: travel.travelDate), let expenses = savedTravel.expenses as? Set<Expense> else {
            return nil
        }
        let result = Array<Expense>(expenses)
        return result
    }
    
    func saveAll(_ expenses: [ExpenseDto], in travel: TravelDto) -> Bool {
        guard let savedTravel: Travel = TravelDao().fetch(by: travel.destination, and: travel.travelDate) else {
            return false
        }
        for expense in expenses.distinct() {
            guard let category = Int16(exactly: expense.category.rawValue), let priority = Int16(exactly: expense.priority) else {
                return false
            }
            let managedExpense = Expense(context: CoreDataManager.manager.persistentContainer.viewContext)
            managedExpense.category = category
            managedExpense.priority = priority
            managedExpense.costValue = expense.costValue
            managedExpense.travel = savedTravel
        }
        if let savedExpenses = fetchAll(of: travel) {
            CoreDataManager.manager.delete(objects: savedExpenses)
        }
        // CoreDataManager.manager.saveContext()
        return true
    }
    
}

