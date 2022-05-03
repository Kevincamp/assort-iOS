//
//  NumberCell.swift
//  wallet
//
//  Created by Kevin Campuzano on 1/14/22.
//

import Foundation
import UIKit
final class NumberCell: UICollectionViewCell {
    
    static let identifier = "NumberPadCell"
    
    @IBOutlet var numberLabel: NumberPadLabel!
    
    var number: Int? {
        didSet {
            if let number = number {
                numberLabel.text = "\(number)"
            }
        }
    }
    
}
