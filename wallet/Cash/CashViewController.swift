//
//  CashViewController.swift
//  wallet
//
//  Created by Kevin Campuzano on 1/21/22.
//

import Foundation
import UIKit

protocol CashViewProtocol: BaseViewProtocol {
    func updateAmount(_ newAmount: String)
}

class CashViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var budgetLabel: UILabel!
    
    var viewModel: CashViewModelProtocol?
    
    private var tempItem: Item!
    private var tempItemNominalIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        if identifier == "SetNominalValueSegue" {
            let nominalSelectedVC = segue.destination as? NominalSelectionViewController
            nominalSelectedVC?.tempItem = tempItem
            nominalSelectedVC?.indexPath = tempItemNominalIndexPath
        }
        
        if identifier == "ResultVCSegue" {
            let resultVC = segue.destination as? ResultViewController
            resultVC?.cashOut = viewModel?.box
            
        }
    }
    
    @IBAction func unwindSegueToBudgetVC(_ segue: UIStoryboardSegue){
        if let nominationSelectedVC = segue.source as? NominalSelectionViewController {
            guard let newItem = nominationSelectedVC.tempItem,
                  let indexPath = nominationSelectedVC.indexPath else {
                return
            }
            self.viewModel?.updateNominationValue(at: indexPath, with: newItem)
            tableView.reloadData()
        }
    }
    
    @IBAction func didTapDoneButton(_ sender: AnyObject) {
        viewModel?.cashOut()
    }
}


// MARK: TableViewDelegate and Datasource
extension CashViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = viewModel?.cashOutList,
           list.count > 0 else {
            return 1
        }
        
        return list.count + 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cashOutlist = viewModel?.cashOutList,
              cashOutlist.count > 0 else {
            let addNominationCell = tableView.dequeueReusableCell(withIdentifier: "AddNominationCellIdentifier", for: indexPath) as UITableViewCell
            return addNominationCell
        }
        
        if indexPath.row == cashOutlist.count {
            let addNominationCell = tableView.dequeueReusableCell(withIdentifier: "AddNominationCellIdentifier", for: indexPath) as UITableViewCell
            return addNominationCell
        }
        
            
        let cashOutIterator = cashOutlist[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NominationCellIdentifier", for: indexPath) as! NominationCell
        cell.viewModel = NominationCellViewModel(nominationValue: cashOutIterator,
                                                 indexPath: indexPath)
        cell.controller = self
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cashOutlist = viewModel?.cashOutList,
              cashOutlist.count > 0 ||
                indexPath.row == cashOutlist.count else {
            return
        }
        
        let defaultItem = Item(nomination: .fiftyCents, quantity: 1)
        viewModel?.addParameter(item: defaultItem)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

extension CashViewController {
    public func didTapDeleteParameter(_ itemIndexPath: IndexPath) {
        viewModel?.deleteParameter(itemIndexPath)
        tableView.deleteRows(at: [itemIndexPath], with: .automatic)
    }
    
    public func didTapNominationButton(_ itemIndexPath: IndexPath) {
        tempItem = viewModel?.getCashOutItem(at: itemIndexPath)
        tempItemNominalIndexPath = itemIndexPath
        performSegue(withIdentifier: "SetNominalValueSegue", sender: self)
    }
    
    public func updateQuantity(at indexPath: IndexPath,
                             quantity: Int) {
        viewModel?.updateQuantityItem(at: indexPath, newQuantity: quantity)
    }
}

extension CashViewController: CashViewProtocol {
    func updateAmount(_ newAmount: String) {
        budgetLabel.text = "$ \(DecimalMasker().mask(String(newAmount)))"
    }
}
