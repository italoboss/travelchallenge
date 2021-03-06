//
//  ExpenseDaoTests.swift
//  TravelChallengeTests
//
//  Created by Italo Boss on 04/09/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import XCTest
import CoreData
@testable import TravelChallenge

class ExpenseDaoTests: XCTestCase {
    
    var sut: ExpenseDao!
    var mockPersistantContext: NSManagedObjectContext!
    
    func test_fetchAllStored_found() {
        let allExpenses = sut.fetchAll()
        XCTAssertEqual(allExpenses?.count, 2)
    }
    
    func test_fetchAllStored_notFound() {
        let allExpenses = ExpenseDao(coreDataManager: CoreDataManager(type: NSBinaryStoreType)).fetchAll()
        XCTAssert(allExpenses == nil || allExpenses?.count == 0)
    }
    
    func test_fetchAllByTravel_found() {
        let dto = TravelDto(with: "MockTravel", travelDate: Date(timeIntervalSinceReferenceDate: 0), savedValue: 0.0)
        let result = sut.fetchAll(of: dto)
        XCTAssertEqual(result?.count, 2)
    }
    
    func test_fetchAllByTravel_notFound() {
        let dto = TravelDto(with: "NotAMockTravel", travelDate: Date(), savedValue: 0.0)
        let result = sut.fetchAll(of: dto)
        XCTAssert(result == nil || result?.count == 0)
    }
    
    func test_saveAllExpensesInTravel_success() {
        let travel = TravelDto(with: "MockTravel", travelDate: Date(timeIntervalSinceReferenceDate: 0), savedValue: 0.0)
        let exp1 = ExpenseDto(with: .transport, priority: 1, costValue: 10.0)
        let exp2 = ExpenseDto(with: .hosting, priority: 2, costValue: 20.0)
        
        let result = sut.saveAll([exp1, exp2], in: travel)
        XCTAssertTrue(result)
    }
    
    override func setUp() {
        super.setUp()
        let manager = CoreDataManager(type: NSInMemoryStoreType)
        mockPersistantContext = manager.persistentContainer.viewContext
        sut = ExpenseDao(coreDataManager: manager)
        initStubs()
    }
    
    override func tearDown() {
        flushData()
        sut = nil
        mockPersistantContext = nil
        super.tearDown()
    }
    
    func initStubs() {
        let travel = NSEntityDescription.insertNewObject(forEntityName: "Travel", into: mockPersistantContext)
        travel.setValue("MockTravel", forKey: "destination")
        travel.setValue(0.0, forKey: "savedValue")
        travel.setValue(Date(timeIntervalSinceReferenceDate: 0), forKey: "travelDate")
        
        let exp1 = NSEntityDescription.insertNewObject(forEntityName: "Expense", into: mockPersistantContext)
        exp1.setValue(1, forKey: "category")
        exp1.setValue(100.0, forKey: "costValue")
        exp1.setValue(1, forKey: "priority")
        exp1.setValue(travel, forKey: "travel")
        
        let exp2 = NSEntityDescription.insertNewObject(forEntityName: "Expense", into: mockPersistantContext)
        exp2.setValue(2, forKey: "category")
        exp2.setValue(200.0, forKey: "costValue")
        exp2.setValue(2, forKey: "priority")
        exp2.setValue(travel, forKey: "travel")
        //travel.setValue(NSSet(array: [exp1, exp2]), forKey: "expenses")
        
        do {
            try mockPersistantContext.save()
        } catch {
            print("Init Stubs Error: \(error)")
        }
    }
    
    func flushData() {
        var fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Travel")
        var objs = try! mockPersistantContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            mockPersistantContext.delete(obj)
        }
        
        fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Expense")
        objs = try! mockPersistantContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            mockPersistantContext.delete(obj)
        }
        
        do {
            try mockPersistantContext.save()
        } catch {
            print("Flush Data Error: \(error)")
        }
    }
    
}
