//
//  ExpenseDtoTests.swift
//  TravelChallengeTests
//
//  Created by Italo Boss on 04/09/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import XCTest
import CoreData
@testable import TravelChallenge

class ExpenseDtoTests: XCTestCase {
    
    var dataManager: CoreDataManager!
    
    override func setUp() {
        super.setUp()
        self.dataManager = CoreDataManager(type: NSInMemoryStoreType)
    }
    
    override func tearDown() {
        self.dataManager = nil
        super.tearDown()
    }
    
    func test_initFromCoreDataEntity_success() {
        let entity = Expense(context: dataManager.persistentContainer.viewContext)
        entity.category = 1
        entity.priority = 1
        entity.costValue = 0.0
        XCTAssertNoThrow( try ExpenseDto(from: entity) )
    }
    
    func test_initFromCoreDataEntity_fail() {
        let entity = Expense(context: dataManager.persistentContainer.viewContext)
        entity.category = -1
        XCTAssertThrowsError( try ExpenseDto(from: entity) )
    }
    
    func test_instanceEqualAnother_success() {
        let lhs = ExpenseDto(with: .transport, priority: 1, costValue: 0.0)
        let rhs = ExpenseDto(with: .transport, priority: 1, costValue: 0.0)
        XCTAssertTrue(lhs == rhs)
    }
    
    func test_instanceEqualAnother_fail() {
        let lhs = ExpenseDto(with: .transport, priority: 1, costValue: 0.0)
        let rhs = ExpenseDto(with: .hosting, priority: 1, costValue: 0.0)
        XCTAssertFalse(lhs == rhs)
    }
    
}
