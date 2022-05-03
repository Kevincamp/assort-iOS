//
//  NumberMasker.swift
//  wallet
//
//  Created by Kevin Campuzano on 1/14/22.
//

import Foundation
class NumberMasker: Masker {
    
    var integerSeparator: String = ProjectConfigurationManager.shared.integerMask
    
    func mask(_ text: String) -> String {
        // remove decimals
        let stringComponents = text.components(separatedBy: ".")
        
        if let numberText = stringComponents.first {
            var array = numberText.map { String($0) }
            var length = array.count
            while length > 3 {
                length = length - 3
                array.insert(integerSeparator, at: length)
            }
            return array.joined(separator: "")
        }
        return text
    }
    
    func maskWithoutDecimals(_ text: String) -> String {
        let stringComponents = text.components(separatedBy: ".")
        if let number = stringComponents.first {
            return number
        }
        return text
    }
    
}
