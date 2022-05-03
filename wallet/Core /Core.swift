//
//  Core.swift
//  wallet
//
//  Created by Kevin Campuzano on 1/29/22.
//

import Foundation
final class Core {
    fileprivate var idealAmountToClose: Double!
    fileprivate var cashOutItems: Dictionary<Nomination, Int>!
    fileprivate var rules: [Item]?
    
    init(idealAmountToClose closeAmount: Double,
         cashOutList: [Item],
         rules: [Item]? = nil) {
        self.idealAmountToClose = closeAmount
        self.rules = rules
        cashOutItems = Dictionary<Nomination, Int>()
        
        for item in cashOutList {
            if cashOutItems.index(forKey: item.nomination) == nil {
                cashOutItems[item.nomination] = item.quantity
            }
            
            if let oldValue = cashOutItems[item.nomination] {
                let itemQuantity = item.quantity
                   cashOutItems[item.nomination] = oldValue + itemQuantity
            }
        }
    }
    
    public func box() -> [Item] {
        var box = [Item]()
        
        // Si acierta en algunas de las reglas entonces se agrega directamente al valor con que el que debe quedar la caja
        if let assertRules = assertRules(),
            var tempAmount = idealAmountToClose {
            box.append(contentsOf: assertRules)
            let diffAmount = assertRules.map({ ($0.nomination.rawValue * Double($0.quantity) )}).reduce(0, +)
            tempAmount = tempAmount - diffAmount
        }
        
        //Ahora si se calcula los demas valores
        for nominal in NOMINAL_LIST {
            if let quantity = cashOutItems[nominal] {
                
            }
        }
        return box
    }
    
    /*
     Funcion assertRules
     Retorna: Reglas cumplidas en base a la cantidad de dinero de caja ingresado
     **/
    fileprivate func assertRules() -> [Item]? {
        var res:[Item] = []
        
        guard let rules = rules else {
            return nil
        }
        
        for rule in rules {
            if let paramQuantity = cashOutItems[rule.nomination] {
                if rule.quantity == paramQuantity {
                    res.append(rule)
                }
            }
        }
        
        return res.count == 0 ? nil : res
    }
}
