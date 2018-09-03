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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let nib = UINib(nibName: "ExpenseCard", bundle: nil)
        expensesListTableView.register(nib, forCellReuseIdentifier: "expenseCardCell")
        
        expensesListTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mainVC = segue.destination as? MainViewController, let trip = sender as? TravelDto {
            mainVC.trip = trip
        }
    }
    
}
extension AddExpensesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
        //return self.trip.expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCardCell", for: indexPath) as! ExpenseCardView
        
        //let expense = self.trip.expenses[indexPath.row]
        
        cell.type = ExpenseCategory(rawValue: indexPath.row)
        
        if indexPath.row % 2 == 0 {
            cell.filled = true
        }else {
            cell.filled = false
        }
        
        //cell.categoryLabel.text = expense.category.name
        //cell.goalTextField.text = String(expense.costValue)
        
        return cell
    }
    
    
}
