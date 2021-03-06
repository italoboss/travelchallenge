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
    
    let dateFormatter = DateFormatter()
    
    let interactor = Interactor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.configureDatePickerOnTextField(travelDateTextField)
        
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = false
        
        self.loadTrip()
        self.updateViewValues()
        
    }
    
    func loadTrip() {
        if let delegate = self.delegate {
            if let trip = delegate.getTripToUpdate() {
                self.trip = trip
            }
            else {
                self.trip = TravelDto(with: "", travelDate: Date(), savedValue: 0.0)
                self.trip?.initExpenses()
            }
        }
    }
    
    func updateViewValues() {
        if let trip = self.trip {
            destinationTextField.text = trip.destination
            travelDateTextField.text = dateFormatter.string(from: trip.travelDate)
            savedValueTextField.text = String(trip.savedValue)
        }
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

    @IBAction func didTapCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveTrip() -> Bool {
        guard let tripDestination = destinationTextField.text else { return false }
        
        guard let datePicker = travelDateTextField.inputView as? UIDatePicker else { return false }
        let tripDate = datePicker.date
        
        guard let tripSavedValueText = savedValueTextField.text else { return false }
        guard let tripSavedValue = Double(tripSavedValueText) else { return false }
        
        let updatedTrip = TravelDto.init(with: tripDestination, travelDate: tripDate, savedValue: tripSavedValue)
        if let trip = self.trip {
            updatedTrip.expenses = trip.expenses
        }
        if updatedTrip.expenses.count == 0 {
            updatedTrip.initExpenses()
        }
        self.trip = updatedTrip
        return TravelRepository().save(travel: updatedTrip)
    }
    

    func configureDatePickerOnTextField(_ sender: UITextField) {
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = .date
        datePickerView.addTarget(self, action: #selector(NewTripViewController.datePickerValueChanged), for: .valueChanged)
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(NewTripViewController.doneDatePicker))
        doneButton.tintColor = UIColor(named: "Blue-Text")
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        sender.inputAccessoryView = toolBar
        sender.inputView = datePickerView
    }
    
    @objc func datePickerValueChanged(datePicker: UIDatePicker) {
        travelDateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func doneDatePicker() {
        view.endEditing(true)
    }
    
    @IBAction func expensesViewTap(_ sender: Any) {
        performSegue(withIdentifier: "NewTripToAddExpenses", sender: nil)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigation = segue.destination as? UINavigationController, let addExpensesVC = navigation.topViewController as? AddExpensesViewController {
            navigation.transitioningDelegate = self
            addExpensesVC.transitioningDelegate = self
            addExpensesVC.interactor = self.interactor
            addExpensesVC.delegate = self
        }
    }
}

extension NewTripViewController: EditExpensesDelegate {
    func getTripToUpdate() -> TravelDto? {
        return self.trip
    }
    
    func didFinished(trip: TravelDto) {
        self.trip?.expenses = trip.expenses
    }
}

extension NewTripViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor :  nil
    }
    
}
