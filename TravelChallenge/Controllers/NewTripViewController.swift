//
//  NewTripViewController.swift
//  TravelChallenge
//
//  Created by Ada 2018 on 29/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import UIKit

class NewTripViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didTapSaveButton(_ sender: Any) {
        performSegue(withIdentifier: "NewTripToAddExpenses", sender: nil)
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
