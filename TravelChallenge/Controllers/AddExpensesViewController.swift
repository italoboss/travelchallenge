//
//  AddExpensesViewController.swift
//  TravelChallenge
//
//  Created by Ada 2018 on 29/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import UIKit

class AddExpensesViewController: UIViewController {
    @IBOutlet weak var expensesListTableView: UITableView!
    var trip: TravelDto?
    var delegate: EditExpensesDelegate?
    
    var interactor: Interactor? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let nib = UINib(nibName: "ExpenseCard", bundle: nil)
        expensesListTableView.register(nib, forCellReuseIdentifier: "expenseCardCell")
        expensesListTableView.dataSource = self
        
        loadExpenses()
    }
    
    func loadExpenses() {
        if let delegate = self.delegate {
            self.trip = delegate.getTripToUpdate()
        }
    }
    
//    func updateViewValues() {
//        if let trip = self.trip {
//
//        }
//    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        completeEdition()
    }
    
    func completeEdition() {
        saveExpenses()
        self.dismiss(animated: true) {
            if let delegate = self.delegate, let trip = self.trip {
                delegate.didFinished(trip: trip)
            }
        }
    }
    
    func saveExpenses() {
        if let trip = self.trip {
            for row in 0...(trip.expenses.count-1) {
                if let cell = self.expensesListTableView.cellForRow(at: IndexPath(row: row, section: 0)) as? ExpenseCardView {
                    trip.expenses[row].costValue = Double(cell.goalTextField.text!) ?? 0.0
                }
            }
        }
    }
    
    @IBAction func handlerPan(_ sender: UIPanGestureRecognizer) {
        let percentThreshold:CGFloat = 0.3
        
        // convert y-position to downward pull progress (percentage)
        let translation = sender.translation(in: view)
        let verticalMovement = translation.y / view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        guard let interactor = interactor else { return }
        
        switch sender.state {
        case .began:
            interactor.hasStarted = true
            completeEdition()
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish
                ? interactor.finish()
                : interactor.cancel()
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mainVC = segue.destination as? MainViewController, let trip = sender as? TravelDto {
            mainVC.trip = trip
        }
    }
    
}

extension AddExpensesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let trip = self.trip {
            return trip.expenses.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCardCell", for: indexPath) as! ExpenseCardView
        
        if let trip = self.trip {
            let expense = trip.expenses[indexPath.row]
            cell.type = expense.category
            cell.goalTextField.text = String(expense.costValue)
            // Setting the flag responsible for the cell style
            cell.filled = expense.costValue > 0
        }
        else {
            cell.type = ExpenseCategory(rawValue: indexPath.row)
            // Setting the flag responsible for the cell style
            cell.filled = false
        }
        
        if let myImage = cell.iconImageView.image {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            cell.iconImageView.image = tintableImage
        }
        
        return cell
    }
}
