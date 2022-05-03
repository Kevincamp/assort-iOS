//
//  NumberPadLabel.swift
//  wallet
//
//  Created by Kevin Campuzano on 1/14/22.
//

import Foundation
import UIKit
class NumberPadLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.layer.cornerRadius = (self.frame.height/3.5)
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.gray.cgColor
        self.backgroundColor = UIColor.gray
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
        self.textColor = UIColor.white
    }
}
