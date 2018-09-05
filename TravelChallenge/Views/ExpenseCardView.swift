//
//  expenseCardView.swift
//  TravelChallenge
//
//  Created by Ada 2018 on 29/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import UIKit

class ExpenseCardView: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var goalTextField: UITextField!
    
    @IBOutlet weak var main: UIView!
    
    var mainColor: UIColor?
    var icon: UIImage?
    var name: String?
    
    var filled: Bool? {
        didSet {
            if self.filled! {
                self.main.backgroundColor = mainColor
                self.categoryLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.iconImageView.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
                self.goalTextField.layer.borderWidth = 0
                self.main.layer.borderWidth = 0
                
            } else {
                self.main.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.main.layer.borderWidth = 2
                self.main.layer.borderColor = mainColor?.cgColor
                self.categoryLabel.textColor = mainColor
                self.iconImageView.tintColor = mainColor
                self.goalTextField.layer.borderWidth = 2
                self.goalTextField.layer.borderColor = mainColor?.cgColor
                
            }
            
        }
    }
    
    var type: ExpenseCategory? {
        
        didSet {
            self.mainColor = type?.getColor()
            self.icon = type?.getIcon()
            self.name = type?.getName()
            
            self.categoryLabel.text = self.name
            self.iconImageView.image = self.icon
            
        }
        
        
    }
    
    override func awakeFromNib() {
        
        self.main.layer.cornerRadius = 5
        self.goalTextField.layer.cornerRadius = 5
        
        self.goalTextField.delegate = self
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
}

extension ExpenseCardView: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
 
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(textField.text!)
        
        guard let t = textField.text else { return true }
        
        if string != "" {
            if let number = Double("\(t)\(string)") {
                print("\(t) - \(number)")
                self.filled = (number > 0)
            }
        } else {
            if let number = Double("\(t.dropLast())") {
                print("\(t) - \(number)")
                self.filled = (number > 0)
            } else {
                self.filled = false            }
        }
        
        return true
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
}

