//
//  MainViewController.swift
//  TravelChallenge
//
//  Created by Ada 2018 on 30/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var expensesTableView: UITableView!
    @IBOutlet weak var btWallet: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var progressValueLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    
    var trip: TravelDto?
    let repository = TravelRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        self.btWallet.layer.cornerRadius = 8
        self.btWallet.layer.borderColor = UIColor(named: "Blue-Border")?.cgColor
        self.btWallet.layer.borderWidth = 2
        
        let nib = UINib(nibName: "ExpenseProgressCard", bundle: nil)
        expensesTableView.register(nib, forCellReuseIdentifier: "expenseProgressCardCell")
        
        self.expensesTableView.dataSource = self
        self.expensesTableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        
        self.loadSavedTrip()
        self.updateViewValues()
    }
    
    func loadSavedTrip() {
        if let storedTrip = repository.getMyTravel() {
            trip = storedTrip
        }
        else {
            trip = nil
        }
    }
    
    func updateViewValues() {
        navigationItem.title = trip?.destination ?? "Sem destino"
        let systemItem: UIBarButtonSystemItem = trip == nil ? .add : .compose
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: systemItem, target: self, action: #selector(MainViewController.didTappedAddOrEditButton))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "AppWhite")
        
        self.updateMainProgress(currentValue: trip?.savedValue ?? 0.0, totalValue: trip?.costValue ?? 0.0)
        
        let countdownDays = 10
        let dailyQuest = countdownDays > 0 ? ((trip?.costValue ?? 0.0) - (trip?.savedValue ?? 0.0)) / Double(countdownDays) : 0.0
        
        goalLabel.text = String(format: "Economize R$ %.2f hoje!", dailyQuest > 0 ? dailyQuest : 0.0)
        countdownLabel.text = "Faltam \(countdownDays) dias"
        self.expensesTableView.reloadData()
    }
    
    func updateMainProgress(currentValue: Double, totalValue: Double) {
            let percent = currentValue / totalValue
            progressValueLabel.text = String(format: "Temos R$ %.2f de R$ %.2f", currentValue, totalValue)
            progressView.progress = Float(percent)
    }
    
    @objc func didTappedAddOrEditButton() {
        performSegue(withIdentifier: "MainToEditTrip", sender: nil)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigation = segue.destination as? UINavigationController,
            let newTripVc = navigation.topViewController as? NewTripViewController {
            newTripVc.delegate = self
        }
    }
    @IBAction func handlerGesture(_ sender: UIPanGestureRecognizer) {
        
    }
    
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let trip = self.trip {
            return trip.expenses.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseProgressCardCell", for: indexPath) as! ExpenseProgressCardView
        
        cell.type = ExpenseCategory(rawValue: indexPath.row)
        
        return cell
    }
 
}

extension MainViewController: AddOrEditTripDelegate {
    
    func getTripToUpdate() -> TravelDto? {
        return self.trip
    }
    
    func didSave(trip: TravelDto) {
        self.trip = trip
        self.updateViewValues()
    }
    
}
