//
//  TravelDaoTests.swift
//  TravelChallengeTests
//
//  Created by Italo Boss on 04/09/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import XCTest
import CoreData
@testable import TravelChallenge

class TravelDaoTests: XCTestCase {
    
    var sut: TravelDao!
    var mockPersistantContext: NSManagedObjectContext!
    
    func test_fetchCurrentTravel_found() {
        let travel = sut.fetchMyTravel()
        XCTAssertEqual(travel?.destination, "MockTravel")
    }
    
    func test_fetchCurrentTravel_notFound() {
        let travel = TravelDao(coreDataManager: CoreDataManager(type: NSBinaryStoreType)).fetchMyTravel()
        XCTAssertNil(travel)
    }
    
    func test_fetchTravelByValues_found() {
        let travel = sut.fetch(by: "MockTravel", and: Date(timeIntervalSinceReferenceDate: 0))
        XCTAssertNotNil(travel)
    }
    
    func test_fetchTravelByValues_notFound() {
        let travel = sut.fetch(by: "NotAMockTravel", and: Date(timeIntervalSinceReferenceDate: 0))
        XCTAssertNil(travel)
    }
    
    func test_saveTravel_success() {
        let travel = TravelDto(with: "", travelDate: Date(), savedValue: 0.0)
        let result = sut.save(travel: travel)
        XCTAssertTrue(result)
    }
    
    func test_updateSavedValueInTravel_success() {
        let travel = TravelDto(with: "MockTravel", travelDate: Date(timeIntervalSinceReferenceDate: 0), savedValue: 0.0)
        let result = sut.update(savedValue: 20.0, from: travel)
        XCTAssertTrue(result)
    }
    
    func test_updateSavedValueInTravel_fail() {
        let travel = TravelDto(with: "NotAMockTravel", travelDate: Date(timeIntervalSinceReferenceDate: 0), savedValue: 0.0)
        let result = sut.update(savedValue: 20.0, from: travel)
        XCTAssertFalse(result)
    }
    
    override func setUp() {
        super.setUp()
        let manager = CoreDataManager(type: NSInMemoryStoreType)
        mockPersistantContext = manager.persistentContainer.viewContext
        sut = TravelDao(coreDataManager: manager)
        initStubs()
    }
    
    override func tearDown() {
        flushData()
        sut = nil
        mockPersistantContext = nil
        super.tearDown()
    }
    
    // MARK: - Mock functions
    
    func initStubs() {
        let obj = NSEntityDescription.insertNewObject(forEntityName: "Travel", into: mockPersistantContext)
        obj.setValue("MockTravel", forKey: "destination")
        obj.setValue(0.0, forKey: "savedValue")
        obj.setValue(Date(timeIntervalSinceReferenceDate: 0), forKey: "travelDate")
        
        do {
            try mockPersistantContext.save()
        } catch {
            print("Init Stubs Error: \(error)")
        }
    }
    
    func flushData() {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Travel")
        let objs = try! mockPersistantContext.fetch(fetchRequest)
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
