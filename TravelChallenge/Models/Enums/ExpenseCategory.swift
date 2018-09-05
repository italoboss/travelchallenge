//
//  Category.swift
//  TravelChallenge
//
//  Created by Karina Paula on 29/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import UIKit

enum ExpenseCategory: Int {
    case transport
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
        
        switch self {
        case .transport:
            return #imageLiteral(resourceName: "002-plane")
        case .hosting:
            return #imageLiteral(resourceName: "003-house")
        case .recreation:
            return #imageLiteral(resourceName: "005-mask")
        case .feed:
            return #imageLiteral(resourceName: "004-fruit")
        case .extra:
            return #imageLiteral(resourceName: "001-leaf")
        }

    }
    
    func getColor() -> UIColor {
        switch self {
        case .transport:
            return UIColor(named: "TransportationColor")!
        case .hosting:
            return UIColor(named: "Lodging")!
        case .recreation:
            return UIColor(named: "Recreation")!
        case .feed:
            return UIColor(named: "FoodColor")!
        case .extra:
            return UIColor(named: "Extras")!

        }
    }
    
}
