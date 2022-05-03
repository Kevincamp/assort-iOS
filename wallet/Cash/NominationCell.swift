//
//  NominationCell.swift
//  wallet
//
//  Created by Kevin Campuzano on 1/21/22.
//

import Foundation
import UIKit

struct NominationCellViewModel {
    var nominationValue: NominalAgregatedValue
    var indexPath: IndexPath
    
    public func nominationText() -> String {
        return nominationValue.getNomination().toString()
    }
    
    public func getQuantity() -> String? {
        guard let quantity = nominationValue.getQuantity() else {
            return nil
        }
        return "\(quantity)"
    }
    
}

final class NominationCell: UITableViewCell, UITextFieldDelegate {
    static let identifier = "NominationCellIdentifier"
    var controller: UIViewController?
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var nominationButton: UIButton!
    @IBOutlet weak var quantityField: UITextField!
    
    func initEventListeners() {
        let didTapDeleteButton = UITapGestureRecognizer(target: self, action: #selector(deleteRow))
        deleteButton.addGestureRecognizer(didTapDeleteButton)
        
        let didTapNominationButton = UITapGestureRecognizer(target: self, action: #selector(setNominalValue))
        nominationButton.addGestureRecognizer(didTapNominationButton)
    }
    
    @objc internal func deleteRow(){
        if let controller = controller as? CashViewController, let viewModel = viewModel {
            controller.deleteValue(controller.tableView,
                                   indexPath: viewModel.indexPath)
        }
    }
    
    @objc internal func setNominalValue() {
        if let controller = controller as? CashViewController, let viewModel = viewModel {
            controller.setNominalValue(controller.tableView,
                                       indexPath: viewModel.indexPath)
        }
    }
    
    
    var viewModel: NominationCellViewModel? {
        didSet {
            if let viewModel = viewModel {
                quantityField.delegate = self
                initEventListeners()
                nominationButton.setTitle(viewModel.nominationText(), for: .normal)
                quantityField.text = viewModel.getQuantity()
                self.selectionStyle = .none
            }
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
                if let controller = controller as? CashViewController,
                    let viewModel = viewModel,
                   let quantityStr = textField.text,
                   let quantity = Int(quantityStr) {
                    controller.updateAmount(controller.tableView,
                                               indexPath: viewModel.indexPath,
                                            quantity: quantity)
                }
    }
    
    
}
