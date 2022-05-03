//
//  NominationCell.swift
//  wallet
//
//  Created by Kevin Campuzano on 1/21/22.
//

import Foundation
import UIKit

struct NominationCellViewModel {
    var nominationValue: Item
    var indexPath: IndexPath
    
    public func nominationText() -> String {
        return nominationValue.nomination.toString()
    }
    
    public func getQuantity() -> String? {
        let quantity = nominationValue.quantity
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
        let didTapDeleteButton = UITapGestureRecognizer(target: self, action: #selector(didTapDeleteParameter))
        deleteButton.addGestureRecognizer(didTapDeleteButton)
        
        let didTapNominationButton = UITapGestureRecognizer(target: self, action: #selector(didTapNominationButton))
        nominationButton.addGestureRecognizer(didTapNominationButton)
    }
    
    @objc internal func didTapDeleteParameter(){
        if let controller = controller as? CashViewController,
            let viewModel = viewModel {
            controller.didTapDeleteParameter(viewModel.indexPath)
        }
    }
    
    @objc internal func didTapNominationButton() {
        if let controller = controller as? CashViewController,
            let viewModel = viewModel {
            controller.didTapNominationButton(viewModel.indexPath)
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
                    controller.updateQuantity(at: viewModel.indexPath,
                                              quantity: quantity)
                }
    }
    
    
}
