//
//  CoreCaseTest.swift
//  CoreCaseTest
//
//  Created by Kevin Campuzano on 1/14/22.
//

import XCTest
@testable import wallet

class CoreCaseTest: XCTestCase {
    
    func test_FromArrayToDict() {
        let cashOut = [
            Item(nomination: .coin, quantity: 5),
            Item(nomination: .one, quantity: 9),
            Item(nomination: .coin, quantity: 5)
        ]
        
        var result = Dictionary<Nomination, Int>()
        result[.coin] = 10
        result[.one] = 9
        
        XCTAssertEqual(Core().unifiedRepeteadValues(cashOutItems: cashOut), result)
        
    }
    
    func test_validateMatchRulesItems() {
        var cashOutItems = Dictionary<Nomination, Int>()
        cashOutItems[.coin] = 7
        cashOutItems[.one] = 9
        cashOutItems[.tenCents] = 7
        cashOutItems[.quarter] = 4
        
        
        let rules = [
            Item(nomination: .coin, quantity: 5),
            Item(nomination: .one, quantity: 9),
            Item(nomination: .tenCents, quantity: 8)
        ]
        
        let result = [Item(nomination: .coin, quantity: 5),
                      Item(nomination: .one, quantity: 9)]
        
        XCTAssertEqual(Core().matchRulesWithCashOut(cashOutItems: cashOutItems, rules: rules), result)
    }
    
    func test_validateEqualItems() {
        var cashOutItems = Dictionary<Nomination, Int>()
        cashOutItems[.coin] = 7
        cashOutItems[.one] = 9
        cashOutItems[.tenCents] = 7
        cashOutItems[.quarter] = 4
        
        
        let rules = [
            Item(nomination: .coin, quantity: 5),
            Item(nomination: .one, quantity: 9),
            Item(nomination: .tenCents, quantity: 8)
        ]
        
        let result = [Item(nomination: .coin, quantity: 5),
                      Item(nomination: .one, quantity: 9)]
        
        XCTAssertEqual(Core().matchRulesWithCashOut(cashOutItems: cashOutItems, rules: rules), result)
    }
    
    func test_validateTryToComplete() {
        let amount = 5.0
        var cashOutItems = Dictionary<Nomination, Int>()
        cashOutItems[.fiftyCents] = 5 // $ 2.50
        cashOutItems[.quarter] = 13 // $ 2.75
        // Total = $ 5.25
        
        let result = Core().tryToComplete(amount: amount, with: cashOutItems)
        
        var sum = 0.0
        for item in result {
            sum = item.key.rawValue * Double(item.value)
        }
        
        XCTAssertEqual(sum, amount)
    }
}
