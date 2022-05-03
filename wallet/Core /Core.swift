//
//  Core.swift
//  wallet
//
//  Created by Kevin Campuzano on 1/29/22.
//

import Foundation
final class Core {
    fileprivate var closeAmount: Double!
    fileprivate var parameters: Dictionary<Nomination, Int>!
    fileprivate var rules: [Rule]?
    
    init(WithCloseAmount closeAmount: Double,
         params: [Item],
         rules: [Rule]? = nil) {
        self.closeAmount = closeAmount
        self.rules = rules
        parameters = Dictionary<Nomination, Int>()
        
        for item in params {
            if parameters.index(forKey: item.nomination) == nil {
                parameters[item.nomination] = item.quantity
            }
            
            if let oldValue = parameters[item.nomination] {
                let itemQuantity = item.quantity
                   parameters[item.nomination] = oldValue + itemQuantity
            }
            
        }
    }
    
    /*
     Funcion assertRules
     Retorna: Reglas cumplidas en base a la cantidad de dinero de caja ingresado
     **/
    fileprivate func assertRules() -> [Rule]? {
        var res:[Rule] = []
        
        guard let rules = rules else {
            return nil
        }
        
        for rule in rules {
            if let paramNomination = parameters[rule.getNomination()] {
                if rule.getQuantity() == paramNomination {
                    res.append(rule)
                }
            }
        }
        
        return res.count == 0 ? nil : res
    }
    
    
    public func box() -> [Item] {
        var amount = closeAmount
        var box = [Item]()
        
        // Si acierta en algunas de las reglas entonces se agrega directamente al valor con que el que debe quedar la caja
//        if let assertRules = assertRules() {
//            box.append(contentsOf: assertRules.map({ $0.toNominalAggregatedValue() }))
//            let diffAmount = assertRules.map({ ($0.getNomination().rawValue * Double($0.getQuantity()) )}).reduce(0, +)
//            amount = amount! - diffAmount
//        }
        
        //Ahora si se calcula los demas valores
        for nominal in NOMINAL_LIST {
            if let quantity = parameters[nominal] {
                
            }
        }
        return box
    }
}
