//
//  CashViewController.swift
//  wallet
//
//  Created by Kevin Campuzano on 1/21/22.
//

import Foundation
import UIKit

protocol CashViewProtocol: BaseViewProtocol {
    
}

class CashViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var budgetLabel: UILabel!
    
    var viewModel: CashViewModelProtocol?
    
    private var amount: Double!
    private var nominationList: [NominalAgregatedValue]!
    
    private var nominalAgregatedValueSelected: NominalAgregatedValue!
    private var nominalAgregatedValueIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nominationList = [NominalAgregatedValue]()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        if identifier == "SetNominalValueSegue" {
            let nominalSelectedVC = segue.destination as? NominalSelectionViewController
            nominalSelectedVC?.nominalSelected = nominalAgregatedValueSelected
            nominalSelectedVC?.indexPath = nominalAgregatedValueIndexPath
        }
        
        if identifier == "ResultVCSegue" {
            let resultVC = segue.destination as? ResultViewController
            
        }
    }
    
    @IBAction func unwindSegueToBudgetVC(_ segue: UIStoryboardSegue){
        if let nominationSelectedVC = segue.source as? NominalSelectionViewController {
            let updatedItem = nominationSelectedVC.nominalSelected
            guard let updatedItemIndexPathRow = nominationSelectedVC.indexPath?.row else {
                return
            }
            nominationList[updatedItemIndexPathRow] = updatedItem!
            tableView.reloadData()
        }
    }
    
    @IBAction func didTapDoneButton(_ sender: AnyObject) {
        
    }
}


extension CashViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if nominationList.count == 0 {
            return 1
        }
        return nominationList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (nominationList.count == 0)  || (indexPath.row == nominationList.count) {
            let addNominationCell = tableView.dequeueReusableCell(withIdentifier: "AddNominationCellIdentifier", for: indexPath) as UITableViewCell
            return addNominationCell
        }
            
        let nominationIterator = nominationList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NominationCellIdentifier", for: indexPath) as! NominationCell
        cell.viewModel = NominationCellViewModel(nominationValue: nominationIterator, indexPath: indexPath)
        cell.controller = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if nominationList.count == 0 || indexPath.row == nominationList.count {
            nominationList.append(NominalAgregatedValue())
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

extension CashViewController {
    public func deleteValue(_ tableView: UITableView,
                            indexPath: IndexPath) {
        nominationList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        recalculateAmount()
    }
    
    public func setNominalValue(_ tableView: UITableView,
                                indexPath: IndexPath) {
        nominalAgregatedValueSelected = nominationList[indexPath.row]
        nominalAgregatedValueIndexPath = indexPath
        performSegue(withIdentifier: "SetNominalValueSegue", sender: self)
        recalculateAmount()
    }
    
    public func updateAmount(_ tableView: UITableView,
                             indexPath: IndexPath,
                             quantity: Int) {
        
        nominationList[indexPath.row].updateQuantity(quantity)
        recalculateAmount()
    }
    
    public func recalculateAmount() {
        var amount = 0.0
        for item in nominationList {
            guard let quantity = item.getQuantity() else {
                      amount += 0
                return
            }
            let nominalRawValue = item.getNomination().rawValue
            amount += (nominalRawValue * Double(quantity))
        }
        
        budgetLabel.text = "$ \(DecimalMasker().mask(String(amount)))"
    }
}

extension CashViewController: CashViewProtocol {
    
}
