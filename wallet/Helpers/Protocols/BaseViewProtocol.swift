//
//  BaseProtocol.swift
//  wallet
//
//  Created by Kevin Campuzano on 5/3/22.
//

import Foundation
protocol BaseViewProtocol: AnyObject {
    func shouldShowLoader(_ show: Bool)
    func shouldShowNoInternetView(_ show: Bool)
}
