//
//  ExpenseCardProgressView.swift
//  TravelChallenge
//
//  Created by Ada 2018 on 30/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import UIKit

class ExpenseProgressCardView: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    var type: ExpenseCategory? {
        didSet {
            //self.backgroundColor = type?.getColor()
            // func getColor() -> UIColor {
//            switch self {
//            case .food:
//                return UIColor(named: "Food")!
//            case .transportation:
//                return UIColor(named: "Transportation")!
//            case .lodge:
//                return UIColor(named: "Lodging")!
//            case .recreation:
//                return UIColor(named: "Recreation")!
//            case .extras:
//                return UIColor(named: "Extras")!
//
//            }
//        }
        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
