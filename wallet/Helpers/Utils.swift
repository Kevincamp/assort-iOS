//
//  Utils.swift
//  wallet
//
//  Created by Kevin Campuzano on 31/5/22.
//

import UIKit

typealias Block = () -> Void

class Utils: NSObject {
    class func performAsync(onCompletion: @escaping Block) {
        Utils.performAfterDelay(delay: 0, onCompletion: onCompletion)
    }

    class func performAfterDelay(delay: Double, onCompletion: @escaping Block) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: {
            onCompletion()
        })
    }

    class func performOnMainThread(onCompletion: @escaping Block) {
        if Thread.isMainThread {
            onCompletion()
        } else {
            Utils.performAsync {
                onCompletion()
            }
        }
    }
}
