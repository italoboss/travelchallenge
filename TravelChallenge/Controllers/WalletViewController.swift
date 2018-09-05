//
//  WalletViewController.swift
//  TravelChallenge
//
//  Created by Ada 2018 on 05/09/2018.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController {

    @IBOutlet weak var walletSegControl: UISegmentedControl!
    @IBOutlet weak var valueTextField: UITextField!
    
    @IBOutlet weak var walletValueLabel: UILabel!
    @IBOutlet weak var spareOrSpendLabel: UILabel!
    @IBOutlet weak var spareOrSpendSignLabel: UILabel!
    @IBOutlet weak var incomeExpenseLabel: UILabel!
  
    @IBOutlet weak var newWalletValueLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func didTapSave(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
