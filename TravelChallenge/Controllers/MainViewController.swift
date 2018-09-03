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
    
    var trip: TravelDto!
    let repository = TravelRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        
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
        if let trip = self.trip {
            navigationItem.title = trip.destination
            // navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: nil, action: nil)
        }
        else {
            navigationItem.title = "Sem destino"
            // navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(MainViewController.didTappedAddOrEditButton))
        }
    }
    
    @IBAction func AddOrEditAction(_ sender: Any) {
        performSegue(withIdentifier: "TripsToNewTrip", sender: nil)
    }
    
    @objc func didTappedAddOrEditButton() {
        performSegue(withIdentifier: "TripsToNewTrip", sender: nil)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigation = segue.destination as? UINavigationController,
            let newTripVc = navigation.topViewController as? NewTripViewController {
            newTripVc.delegate = self
        }
    }

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseProgressCardCell", for: indexPath) as! ExpenseProgressCardView
        
        cell.type = ExpenseCategory(rawValue: indexPath.row+1)
        
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
