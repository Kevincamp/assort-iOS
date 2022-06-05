//
//  Nominal.swift
//  wallet
//
//  Created by Kevin Campuzano on 1/22/22.
//

import Foundation
public enum Nomination: Double, Codable {
    case coin = 0.01
    case fiveCents = 0.05
    case tenCents = 0.10
    case quarter = 0.25
    case fiftyCents = 0.50
    case one = 1.00
    case five = 5.00
    case ten = 10.00
    case twenty = 20.00
    
    func toString() -> String {
        let nominationStr = "\(self.rawValue)"
        return "$ \(DecimalMasker().mask(nominationStr))"
    }
}

extension Nomination: Equatable {
    public static func == (lhs: Nomination, rhs: Nomination) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
