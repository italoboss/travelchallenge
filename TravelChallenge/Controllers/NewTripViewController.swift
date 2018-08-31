//
//  NewTripViewController.swift
//  TravelChallenge
//
//  Created by Ada 2018 on 29/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import UIKit

class NewTripViewController: UIViewController {

    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var travelDateTextField: UITextField!
    @IBOutlet weak var savedValueTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didTapSaveButton(_ sender: Any) {
        let tripDestination = destinationTextField.text!
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en_US")
        let tripDate =  dateFormatter.date(from: destinationTextField.text!)!
        
        let tripSavedValue = Double(savedValueTextField.text!)!
        
        
        let trip =  TravelDto.init(with: tripDestination, travelDate: tripDate, savedValue: tripSavedValue)
        if TravelRepository().save(travel: trip){
            
            print(TravelRepository().getMyTravel()!)
            
            performSegue(withIdentifier: "NewTripToAddExpenses", sender: nil)
            
        }
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
