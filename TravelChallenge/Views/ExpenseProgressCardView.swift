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
    @IBOutlet weak var main: UIView!
    
    var type: ExpenseCategory? {
        didSet {
            self.main.backgroundColor = type?.getColor()
            self.categoryLabel.text = type?.getName()
            self.iconImageView.image = type?.getIcon()
            
        }
    }
    
    override func awakeFromNib() {
        self.main.layer.cornerRadius = 4
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
