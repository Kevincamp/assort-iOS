//
//  String+Convert.swift
//  wallet
//
//  Created by Kevin Campuzano on 5/3/22.
//

import Foundation
extension String {
    func convertToDouble() -> Double {
        guard let value = Double(self) else {
            return 0
        }
        
        return value
    }
}
