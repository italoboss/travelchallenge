//
//  Category.swift
//  TravelChallenge
//
//  Created by Karina Paula on 29/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

enum ExpenseCategory: Int {
    case transport = 1
    case hosting
    case feed
    case recreation
    case extra
}

extension ExpenseCategory {
    static var allCases: [ExpenseCategory] {
        let cases = [
            ExpenseCategory.transport,
            ExpenseCategory.hosting,
            ExpenseCategory.feed,
            ExpenseCategory.recreation,
            ExpenseCategory.extra
        ]
        return cases
    }
}
