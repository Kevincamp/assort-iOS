//
//  ResultViewController.swift
//  wallet
//
//  Created by Kevin Campuzano on 5/3/22.
//

import Foundation
import UIKit

class ResultViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var cashOut: [Item]!
    
    override func viewDidLoad() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.title = "Result"
    }
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }
        
        return cashOut.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            // Celda de total
            let cell = tableView.dequeueReusableCell(withIdentifier: "totalCell", for: indexPath) as UITableViewCell
            let amount = cashOut.map({ ($0.nomination.rawValue * Double($0.quantity) )}).reduce(0, +)
            cell.textLabel?.text = "$ \(DecimalMasker().mask(String(amount)))"
            return cell
        }
        
        //Celda de valores
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = cashOut[indexPath.row].nomination.toString()
        let quantity = cashOut[indexPath.row].quantity
        cell.detailTextLabel?.text = String(quantity)
        return cell
    }
    
}
