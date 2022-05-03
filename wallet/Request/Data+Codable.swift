//
//  Data+Codable.swift
//  wallet
//
//  Created by Kevin Campuzano on 5/2/22.
//

import Foundation

extension Data {
    func decoded<T>(
        _ type: T.Type,
        useDefaultStrategy: Bool = false,
        dateDecodingFormatter: DateFormatter? = nil) -> Result<T, CustomError> where T: Decodable {
        return decoded(type, decodingStrategy: useDefaultStrategy ? .useDefaultKeys : .convertFromSnakeCase, dateDecodingFormatter: dateDecodingFormatter)
    }

    func decoded<T>(
        _ type: T.Type,
        decodingStrategy: JSONDecoder.KeyDecodingStrategy,
        dateDecodingFormatter: DateFormatter? = nil) -> Result<T, CustomError> where T: Decodable {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = decodingStrategy

        if let dateDecodingFormatter = dateDecodingFormatter {
            decoder.dateDecodingStrategy = .custom({ decoder in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                return dateDecodingFormatter.date(from: dateString) ?? Date()
            })
        } else {
            decoder.dateDecodingStrategy = .iso8601
        }

        do {
            let result = try decoder.decode(type, from: self)
            return .success(result)
        } catch {
            print(error)
            return .failure(.invalidData)
        }
    }
}
