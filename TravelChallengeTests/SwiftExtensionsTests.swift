//
//  SwiftExtensionsTests.swift
//  TravelChallengeTests
//
//  Created by Italo Boss on 04/09/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import XCTest
@testable import TravelChallenge

class SwiftExtensionsTests: XCTestCase {
    
    func test_extensionArrayCopyWithDistinctElements() {
        let test = [1, 2, 2, 1, 3, 3]
        let goal = [1, 2, 3]
        XCTAssertEqual(test.distinct(), goal)
    }
    
}
