//
//  UIColor+Extension.swift
//  wallet
//
//  Created by Kevin Campuzano on 1/14/22.
//

import Foundation
import UIKit

extension UIColor {
    
    open class var dulceArtePrimaryColor : UIColor{
        get{
            return UIColor.color(withString: "#FF9200")
        }
    }
    
    open class var solidColor: UIColor{
        get{
            
            return UIColor.color(withString: "#F7F7F7")
        }
    }
    
    // MARK: - Functions
    class func color(withString str: String) -> UIColor {
        switch(str) {
        case "white":
            return UIColor.white
        case "black":
            return UIColor.black
        default:
            return color(withHexadecimalString: str)
        }
    }
    
    class func color(withHexadecimalString str: String) -> UIColor {
        var rgbValue: UInt32 = 0
        let scanner: Scanner = Scanner(string: str)
        scanner.scanLocation = 1
        scanner.scanHexInt32(&rgbValue)
        
        let redColor: CGFloat = CGFloat(CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0)
        let greenColor: CGFloat = CGFloat(CGFloat((rgbValue & 0xFF00) >> 8) / 255.0)
        let blueColor: CGFloat = CGFloat(CGFloat(rgbValue & 0xFF) / 255.0)
        return UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)
    }
    
    class func random() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
}
