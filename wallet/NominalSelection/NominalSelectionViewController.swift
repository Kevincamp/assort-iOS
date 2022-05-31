//
//  NominalSelectionViewController.swift
//  wallet
//
//  Created by Kevin Campuzano on 1/22/22.
//

import Foundation
import UIKit

let NOMINAL_LIST = [ Nomination.coin, Nomination.fiveCents, Nomination.tenCents,
                     Nomination.quarter, Nomination.fiftyCents, Nomination.one,
                     Nomination.five, Nomination.ten, Nomination.twenty]

class NominalSelectionViewController: UIViewController {
    var tempItem: Item!
    var indexPath: IndexPath!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension NominalSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NOMINAL_LIST.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nominalIterator = NOMINAL_LIST[indexPath.row]
        
        let nominalCell = tableView.dequeueReusableCell(withIdentifier: "nominalDescriptionCellIdentifier", for: indexPath) as UITableViewCell
        var content = nominalCell.defaultContentConfiguration()
        content.text = nominalIterator.toString()
        if tempItem.nomination == nominalIterator {
            nominalCell.accessoryType = .checkmark
        }
        nominalCell.textLabel?.text = nominalIterator.toString()
        return nominalCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tempItem.nomination = NOMINAL_LIST[indexPath.row]
        performSegue(withIdentifier: "unwindSegueToBudgetVC", sender: self)
    }
}
