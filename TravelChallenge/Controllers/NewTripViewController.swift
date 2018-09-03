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
    
    var delegate: AddOrEditTripDelegate?
    var trip: TravelDto?
    
    override func viewDidLoad() {
        super.viewDidLoad()

<<<<<<< HEAD
        self.loadTrip()
        self.updateViewValues()
    }
    
    func loadTrip() {
        if let delegate = self.delegate {
            self.trip = delegate.getTripToUpdate()
        }
    }
    
    func updateViewValues() {
        if let trip = self.trip {
            destinationTextField.text = trip.destination
            travelDateTextField.text = String(describing: trip.travelDate)
            savedValueTextField.text = String(trip.savedValue)
        }
=======
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = false
        
        // Do any additional setup after loading the view.
>>>>>>> 3bd640cdd3c2fcd936848527bae4f779ef13e4c0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didTapSaveButton(_ sender: Any) {
        if self.saveTrip() {
            self.dismiss(animated: true) {
                if let delegate = self.delegate, let trip = self.trip {
                    delegate.didSave(trip: trip)
                }
            }
        }
    }
    
    func saveTrip() -> Bool {
        guard let tripDestination = destinationTextField.text else { return false }
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale.init(identifier: "en_US")
//        guard let tripDateText = travelDateTextField.text else { return false }
//        guard let tripDate =  dateFormatter.date(from: tripDateText) else { return false }
        
        guard let tripSavedValueText = savedValueTextField.text else { return false }
        guard let tripSavedValue = Double(tripSavedValueText) else { return false }
        
        trip = TravelDto.init(with: tripDestination, travelDate: Date(), savedValue: tripSavedValue)
        
        return TravelRepository().save(travel: trip!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addExpensesVC = segue.destination as? AddExpensesViewController, let trip = sender as? TravelDto {
            addExpensesVC.trip = trip
        }
    }

}
