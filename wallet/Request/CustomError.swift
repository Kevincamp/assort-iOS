//
//  CustomError.swift
//  wallet
//
//  Created by Kevin Campuzano on 5/2/22.
//

import Foundation
enum CustomError: LocalizedError {
    case invalidURL
    case invalidBody
    case invalidResponse
    case invalidData
    case unauthorized
    case serverError
    case notConnectedToInternet
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidBody:
            return "Invalid Body"
        case .invalidResponse:
            return "Invalid response"
        case .invalidData:
            return "Invalid Data"
        case .unauthorized:
            return "You are unauthorized to access"
        case .notConnectedToInternet:
            return "Not connected to Internet"
        case .serverError, .unknown:
            return "Somehting went wronng. Try again later!"
        }
    }
}
