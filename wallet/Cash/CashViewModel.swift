//
//  CashViewModel.swift
//  wallet
//
//  Created by Kevin Campuzano on 5/3/22.
//

import Foundation
protocol CashViewModelProtocol {
    var idealAmountToClose: Double { get }
    var rules: [Item] { get }
    
    var amount: Double { get }
    var cashOutList: [Item] { get }
    
    var box: [Item] { get }
    
    func getCashOutItem(at indePath: IndexPath) -> Item
    func addParameter(item:Item)
    func deleteParameter(_ itemIndexPath: IndexPath)
    func updateNominationValue(at itemIndexPath: IndexPath, with newItem: Item)
    func updateQuantityItem(at itemIndexPath: IndexPath, newQuantity: Int)
    
    func cashOut()
}


class CashViewModel: CashViewModelProtocol {
    
    
    weak var view: CashViewProtocol?
    
    // MARK: Arrived vars
    var idealAmountToClose: Double
    var rules: [Item]
    
    // MARK: Local vars
    var amount: Double = 0 {
        didSet {
            let strAmount = String(amount)
            view?.updateAmount(strAmount)
        }
    }
    
    var cashOutList: [Item] = []
    
    var box: [Item] = []
    
    init(idealAmountToClose: Double,
         rules: [Item]) {
        self.idealAmountToClose = idealAmountToClose
        self.rules = rules
    }
    
    func getCashOutItem(at indePath: IndexPath) -> Item {
        return self.cashOutList[indePath.row]
    }
    
    func addParameter(item:Item) {
        cashOutList.append(item)
        recalculateAmount()
    }
    
    func deleteParameter(_ itemIndexPath: IndexPath) {
        cashOutList.remove(at: itemIndexPath.row)
        recalculateAmount()
    }
    
    func updateNominationValue(at itemIndexPath: IndexPath, with newItem: Item){
        cashOutList[itemIndexPath.row] = newItem
        recalculateAmount()
    }
    
    func updateQuantityItem(at itemIndexPath: IndexPath, newQuantity: Int) {
        cashOutList[itemIndexPath.row].quantity = newQuantity
        recalculateAmount()
    }
    
    func recalculateAmount(){
        var amount = 0.0
        for item in cashOutList {
            let quantity = item.quantity
            let nominalRawValue = item.nomination.rawValue
            amount += (nominalRawValue * Double(quantity))
        }
        self.amount = amount
    }
    
    func cashOut() {
        self.box = Core(idealAmountToClose: idealAmountToClose,
             cashOutList: cashOutList,
             rules: rules).box()
        
    }
}
