//
//  ExpenseCategoryTest.swift
//  TravelChallengeTests
//
//  Created by Italo Boss on 04/09/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import XCTest
@testable import TravelChallenge

class ExpenseCategoryTests: XCTestCase {
    
    func test_gettingAllCases() {
        let allCases: [ExpenseCategory] = [
            .transport,
            .hosting,
            .feed,
            .recreation,
            .extra
        ]
        XCTAssertEqual(allCases, ExpenseCategory.allCases)
    }
    
    // MARK: Category's Name tests
    
    func test_nameOfCategory_transport() {
        let category: ExpenseCategory = .transport
        XCTAssertEqual(category.getName(), "Transporte")
    }
    
    func test_nameOfCategory_hosting() {
        let category: ExpenseCategory = .hosting
        XCTAssertEqual(category.getName(), "Hospedagem")
    }
    
    func test_nameOfCategory_feed() {
        let category: ExpenseCategory = .feed
        XCTAssertEqual(category.getName(), "Alimentação")
    }
    
    func test_nameOfCategory_recreation() {
        let category: ExpenseCategory = .recreation
        XCTAssertEqual(category.getName(), "Lazer")
    }
    
    func test_nameOfCategory_extra() {
        let category: ExpenseCategory = .extra
        XCTAssertEqual(category.getName(), "Extras")
    }
    
    // MARK: Category's Color tests
    
    func test_colorOfCategory_transport() {
        let color = UIColor(named: "Transportation", in: Bundle.main, compatibleWith: nil)
        XCTAssertEqual(ExpenseCategory.transport.getColor(), color)
    }
    
    func test_colorOfCategory_hosting() {
        let color = UIColor(named: "Lodging", in: Bundle.main, compatibleWith: nil)
        XCTAssertEqual(ExpenseCategory.hosting.getColor(), color)
    }
    
    func test_colorOfCategory_feed() {
        let color = UIColor(named: "Food", in: Bundle.main, compatibleWith: nil)
        XCTAssertEqual(ExpenseCategory.feed.getColor(), color)
    }
    
    func test_colorOfCategory_recreation() {
        let color = UIColor(named: "Recreation", in: Bundle.main, compatibleWith: nil)
        XCTAssertEqual(ExpenseCategory.recreation.getColor(), color)
    }
    
    func test_colorOfCategory_extra() {
        let color = UIColor(named: "Extras", in: Bundle.main, compatibleWith: nil)
        XCTAssertEqual(ExpenseCategory.extra.getColor(), color)
    }
    
}
