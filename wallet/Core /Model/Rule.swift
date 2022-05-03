//
//  Rule.swift
//  wallet
//
//  Created by Kevin Campuzano on 1/29/22.
//

import Foundation
public class Rule {
    private var quantity: Int!
    private var nomination: Nomination!

    init(quantity: Int,
         nomination: Nomination) {
        self.quantity = quantity
        self.nomination = nomination
    }

    public func getQuantity() -> Int {
        return self.quantity
    }

    public func getNomination() -> Nomination {
        return self.nomination
    }

//    public func toNominalAggregatedValue() -> Item {
//        let value = NominalAgregatedValue()
//        value.updateQuantity(self.quantity)
//        value.updateNomination(self.nomination)
//        return value
//    }
    
    init(cashOutItem: Item) {
        self.quantity = cashOutItem.quantity
        self.nomination = Nomination.init(rawValue: cashOutItem.nomination.rawValue)
    }
}
