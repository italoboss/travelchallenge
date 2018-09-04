//
//  Category.swift
//  TravelChallenge
//
//  Created by Karina Paula on 29/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import UIKit

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
    
    func getName() -> String {
        switch self {
        case .feed:
            return "Alimentação"
        case .transport:
            return "Transporte"
        case .hosting:
            return "Hospedagem"
        case .recreation:
            return "Lazer"
        case .extra:
            return "Extras"
            
        }
    }
    
    func getIcon() -> UIImage {
        return UIImage()
    }
    
    func getColor() -> UIColor {
        switch self {
        case .feed:
            return UIColor(named: "Food")!
        case .transport:
            return UIColor(named: "Transportation")!
        case .hosting:
            return UIColor(named: "Lodging")!
        case .recreation:
            return UIColor(named: "Recreation")!
        case .extra:
            return UIColor(named: "Extras")!

        }
    }
    
}
