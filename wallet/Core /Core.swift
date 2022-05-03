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
         params: [NominalAgregatedValue],
         rules: [Rule]? = nil) {
        self.closeAmount = closeAmount
        self.rules = rules
        parameters = Dictionary<Nomination, Int>()
        
        for item in params {
            if parameters.index(forKey: item.getNomination()) == nil {
                parameters[item.getNomination()] = item.getQuantity()
            }
            
            if let oldValue = parameters[item.getNomination()],
               let itemQuantity = item.getQuantity() {
                parameters[item.getNomination()] = oldValue + itemQuantity
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
    
    
    public func box() -> [NominalAgregatedValue] {
        var amount = closeAmount
        var box = [NominalAgregatedValue]()
        
        // Si acierta en algunas de las reglas entonces se agrega directamente al valor con que el que debe quedar la caja
        if let assertRules = assertRules() {
            box.append(contentsOf: assertRules.map({ $0.toNominalAggregatedValue() }))
            let diffAmount = assertRules.map({ ($0.getNomination().rawValue * Double($0.getQuantity()) )}).reduce(0, +)
            amount = amount! - diffAmount
        }
        
        //Ahora si se calcula los demas valores
        for nominal in NOMINAL_LIST {
            if let quantity = parameters[nominal] {
                
            }
        }
        return box
    }
}
