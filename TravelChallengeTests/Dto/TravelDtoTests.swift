//
//  TravelDtoTests.swift
//  TravelChallengeTests
//
//  Created by Italo Boss on 04/09/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import XCTest
import CoreData
@testable import TravelChallenge

class TravelDtoTests: XCTestCase {
    
    var dataManager: CoreDataManager!
    
    override func setUp() {
        super.setUp()
        self.dataManager = CoreDataManager(type: NSInMemoryStoreType)
    }
    
    override func tearDown() {
        self.dataManager = nil
        super.tearDown()
    }
    
    func test_initWithValues() {
        let sut = TravelDto(with: "Travel", travelDate: Date(), savedValue: 0.0)
        XCTAssertNotNil(sut)
    }
    
    func test_initExpenseArray() {
        let sut = TravelDto(with: "Travel", travelDate: Date(), savedValue: 0.0)
        sut.initExpenses()
        XCTAssertGreaterThan(sut.expenses.count, 0)
    }
    
    func test_initFromCoreDataEntity_success() {
        let entity = Travel(context: dataManager.persistentContainer.viewContext)
        entity.destination = ""
        entity.createdAt = Date()
        entity.savedValue = 0.0
        entity.travelDate = Date()
        XCTAssertNoThrow(try TravelDto(from: entity))
    }
    
    func test_initFromCoreDataEntity_fail() {
        let entity = Travel(context: dataManager.persistentContainer.viewContext)
        XCTAssertThrowsError(try TravelDto(from: entity))
    }
    
}
