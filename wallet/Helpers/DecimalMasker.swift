//
//  DecimalMasker.swift
//  wallet
//
//  Created by Kevin Campuzano on 1/14/22.
//

import Foundation
public class DecimalMasker: Masker {
    
    var decimalSeparator: String = ProjectConfigurationManager.shared.decimalMask
    var integerSeparator: String = ProjectConfigurationManager.shared.integerMask
    var decimalMaxLenght : Int = ProjectConfigurationManager.shared.decimalMaxLength
    var decimalMaxLenghtCuotapartes : Int = ProjectConfigurationManager.shared.decimalMaxLengthCuotapartes
    
    
    func mask(_ text: String) -> String {
        let isNegative = text.prefix(1) == "-"
        var textWithoutSymbols = text.replacingOccurrences(of: "-", with: "")
        textWithoutSymbols = textWithoutSymbols.replacingOccurrences(of: " ", with: "")
        if let textFloat = Double(textWithoutSymbols) {
            textWithoutSymbols = String(format: "%.\(decimalMaxLenght)f", textFloat)
        }
        
        var textDecimal = textWithoutSymbols
        textDecimal = textDecimal.replacingOccurrences(of: ".", with: decimalSeparator)
        textDecimal = textDecimal.replacingOccurrences(of: ",", with: decimalSeparator)
        
        var stringWithoutDecimals = textWithoutSymbols

        var stringDecimals = ""
        if let decimalIndex = textDecimal.firstIndex(of: Character(decimalSeparator)) {
            stringDecimals = String(textDecimal[decimalIndex..<textWithoutSymbols.endIndex])
            stringWithoutDecimals = String(textDecimal[textWithoutSymbols.startIndex..<decimalIndex])
        }
        stringWithoutDecimals = (isNegative ? "-" : "") + NumberMasker().mask(stringWithoutDecimals)
        return stringWithoutDecimals + stringDecimals
    }
    
    func maskWithoutDecimal(_ text: String) -> String {
        let isNegative = text.prefix(1) == "-"
        var textWithoutSymbols = text.replacingOccurrences(of: "-", with: "")
        textWithoutSymbols = textWithoutSymbols.replacingOccurrences(of: " ", with: "")
        if let textFloat = Double(textWithoutSymbols) {
            textWithoutSymbols = String(format: "%.\(decimalMaxLenght)f", textFloat)
        }
        
        var textDecimal = textWithoutSymbols
        textDecimal = textDecimal.replacingOccurrences(of: ".", with: decimalSeparator)
        textDecimal = textDecimal.replacingOccurrences(of: ",", with: decimalSeparator)
        
        var stringWithoutDecimals = textWithoutSymbols
        
        if let decimalIndex = textDecimal.firstIndex(of: Character(decimalSeparator)) {
            stringWithoutDecimals = String(textDecimal[textWithoutSymbols.startIndex..<decimalIndex])
        }
        stringWithoutDecimals = (isNegative ? "-" : "") + NumberMasker().mask(stringWithoutDecimals)
        return stringWithoutDecimals
    }
    
    func maskWithCurrency(_ currency:String, text:String) -> String {
        let isNegative = text.prefix(1) == "-"
        let value = mask(text)
        let textWithoutSymbols = value.replacingOccurrences(of: "-", with: "")
        let stringWithDecimal = (isNegative ? "-" : "") + currency + " " + textWithoutSymbols
        return stringWithDecimal
    }
    
    func maskFairCuotapartes(_ text: String) -> String {
        let isNegative = text.prefix(1) == "-"
        var textWithoutSymbols = text.replacingOccurrences(of: "-", with: "")
        textWithoutSymbols = textWithoutSymbols.replacingOccurrences(of: " ", with: "")
        if let textFloat = Double(textWithoutSymbols) {
            textWithoutSymbols = String(format: "%.\(decimalMaxLenghtCuotapartes)f", textFloat)
        }
        
        var textDecimal = textWithoutSymbols
        textDecimal = textDecimal.replacingOccurrences(of: ".", with: decimalSeparator)
        textDecimal = textDecimal.replacingOccurrences(of: ",", with: decimalSeparator)
        
        var stringWithoutDecimals = textWithoutSymbols

        var stringDecimals = ""
        if let decimalIndex = textDecimal.firstIndex(of: Character(decimalSeparator)) {
            stringDecimals = String(textDecimal[decimalIndex..<textWithoutSymbols.endIndex])
            stringWithoutDecimals = String(textDecimal[textWithoutSymbols.startIndex..<decimalIndex])
        }
        stringWithoutDecimals = (isNegative ? "-" : "") + NumberMasker().mask(stringWithoutDecimals)
        return stringWithoutDecimals + stringDecimals
    }
    
}
