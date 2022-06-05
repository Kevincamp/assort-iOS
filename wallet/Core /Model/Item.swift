//
//  CashOutItem.swift
//  wallet
//
//  Created by Kevin Campuzano on 5/2/22.
//

import Foundation
public struct Item: Codable {
    var nomination: Nomination
    var quantity: Int
}

extension Item: Equatable {
    public static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.nomination == rhs.nomination && lhs.quantity == rhs.quantity
    }
}
