//
//  NominalAgregatedValue.swift
//  wallet
//
//  Created by Kevin Campuzano on 1/23/22.
//

import Foundation
public class NominalAgregatedValue {
    
    private var nomination: Nomination!
    private var quantity: Int?
    
    init() {
        nomination = .five
    }
    
    
    public func updateNomination(_ newNomination: Nomination) {
        nomination = newNomination
    }
    
    public func updateQuantity(_ qty: Int) {
        quantity = qty
    }
    
    public func getNomination() -> Nomination {
        return nomination
    }
    
    public func getQuantity() -> Int? {
        return quantity
    }
}
