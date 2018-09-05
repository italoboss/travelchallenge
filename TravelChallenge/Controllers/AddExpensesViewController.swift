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
    var trip: TravelDto!
    
    var interactor: Interactor? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let nib = UINib(nibName: "ExpenseCard", bundle: nil)
        expensesListTableView.register(nib, forCellReuseIdentifier: "expenseCardCell")
        
        expensesListTableView.dataSource = self
    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        print("Did tap save btn")
        self.dismiss(animated: true, completion: nil)
    }
    
    func  saveExpenses(){
        for row in 0...self.trip.expenses.count{
            let cell = self.expensesListTableView.dequeueReusableCell(withIdentifier: "expenseCardCell", for: IndexPath.init(row: row, section: 0)) as! ExpenseCardView
            
            self.trip.expenses[row].costValue = Double(cell.goalTextField.text!) ?? 0.0
        }
        
        if ExpenseRepository().saveAll(self.trip.expenses, in: self.trip){
            performSegue(withIdentifier: "AddExpensesToMain", sender: nil)
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
            dismiss(animated: true, completion: nil)
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
        
        return 5
        //return self.trip.expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCardCell", for: indexPath) as! ExpenseCardView
        
        //let expense = self.trip.expenses[indexPath.row]
        
        cell.type = ExpenseCategory(rawValue: indexPath.row)
        
        // Setting the flag responsible for the cell style
        cell.filled = false
        if let myImage = cell.iconImageView.image {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            cell.iconImageView.image = tintableImage
        }
        cell.iconImageView.tintColor = cell.type?.getColor()
        
        
        //cell.categoryLabel.text = expense.category.name
        //cell.goalTextField.text = String(expense.costValue)
        
        return cell
    }
}
