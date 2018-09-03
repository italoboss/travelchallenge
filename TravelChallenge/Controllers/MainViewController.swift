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
    
    @IBOutlet weak var tripDestinationLabel: UILabel!
    
    var trip: TravelDto!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ExpenseProgressCard", bundle: nil)
        expensesTableView.register(nib, forCellReuseIdentifier: "expenseProgressCardCell")
        
        self.expensesTableView.dataSource = self
        
        self.expensesTableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseProgressCardCell", for: indexPath) as! ExpenseProgressCardView
        
        switch indexPath.row {
        case 0:
            cell.type = 
        default:
            <#code#>
        }
        
        return cell
    }
 
    
}
