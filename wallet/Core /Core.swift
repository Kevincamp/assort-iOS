//
//  Core.swift
//  wallet
//
//  Created by Kevin Campuzano on 1/29/22.
//

import Foundation
class Core {
//    fileprivate var idealAmountToClose: Double!
//    fileprivate var cashOutItems: Dictionary<Nomination, Int>!
//    fileprivate var rules: [Item]?
    
//    init(idealAmountToClose closeAmount: Double,
//         cashOutList: [Item],
//         rules: [Item]? = nil) {
//        self.idealAmountToClose = closeAmount
//        self.rules = rules
//        cashOutItems = Dictionary<Nomination, Int>()
//    }
    
    public func box() -> [Item] {
        return []
    }
    
    /*
     Funcion unifiedRepeteadValues
     Retorna: Retorna la suma de los valores de una moneda en especifico
     **/
    public func unifiedRepeteadValues(cashOutItems: [Item]) -> Dictionary<Nomination, Int> {
        var res =  Dictionary<Nomination, Int>()
        for item in cashOutItems {
            if let oldValue = res[item.nomination] {
                let itemQuantity = item.quantity
                res[item.nomination] = oldValue + itemQuantity
            } else {
                res[item.nomination] = item.quantity
            }
        }
        return res
    }
    
    /*
     Funcion assertRules
     Retorna: Reglas cumplidas en base a la cantidad de dinero de caja ingresado
     **/
    public func matchRulesWithCashOut(cashOutItems: Dictionary<Nomination, Int>,
                                      rules: [Item]?) -> [Item]? {
        var res:[Item] = []
        
        if let rules = rules {
            for rule in rules {
                if let paramQuantity = cashOutItems[rule.nomination] {
                    if paramQuantity >= rule.quantity {
                        res.append(rule)
                    }
                }
            }
        }
        
        return res
    }
    
    public func tryToComplete(amount: Double, with cashOutItems:Dictionary<Nomination, Int>) -> Dictionary<Nomination, Int> {
        
        var res: Dictionary<Nomination, Int> =
        Dictionary<Nomination, Int>()
        
        var currentAmount = amount
        
        let orderNomination:[Nomination] = [.one,
                                            .fiftyCents,
                                            .quarter,
                                            .tenCents,
                                            .fiveCents,
                                            .five,
                                            .ten,
                                            .twenty]
        
        for nomination in orderNomination {
            if currentAmount == 0 {
                break
            }
            
            // multiplo de nominacion que necesito para llegar al amount
            let remainder = (currentAmount / nomination.rawValue).rounded(.towardZero)
            
            // Si mi cantidad es menor o igual a la cantidad de
            if let quantity = cashOutItems[nomination] {
                
                if quantity >= Int(remainder) {
                    let amount = nomination.rawValue * Double(remainder)
                    res[nomination] = Int(remainder)
                    currentAmount -= amount
                } else {
                    let amount = nomination.rawValue * Double(quantity)
                    res[nomination] = quantity
                    currentAmount -= amount
                }
            }
        }
        return res
    }
}
