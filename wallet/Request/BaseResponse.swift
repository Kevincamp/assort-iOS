//
//  BaseResponse.swift
//  wallet
//
//  Created by Kevin Campuzano on 5/2/22.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let responseCode: Int?
    let responseMessage: String?
    let responseData: T
}
