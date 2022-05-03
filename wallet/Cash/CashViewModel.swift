//
//  CashViewModel.swift
//  wallet
//
//  Created by Kevin Campuzano on 5/3/22.
//

import Foundation
protocol CashViewModelProtocol {
    var idealAmountToClose: Double { get }
    var rules: [Rule] { get }
    
}


class CashViewModel: CashViewModelProtocol {
    weak var view: CashViewProtocol?
    
    var idealAmountToClose: Double
    var rules: [Rule]
    
    init(idealAmountToClose: Double,
         rules: [Rule]) {
        self.idealAmountToClose = idealAmountToClose
        self.rules = rules
        
    }
}
