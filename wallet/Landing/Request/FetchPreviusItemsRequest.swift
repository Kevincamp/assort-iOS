//
//  FetchPreviusItemsRequest.swift
//  wallet
//
//  Created by Kevin Campuzano on 5/2/22.
//

import Foundation
struct FetchPreviusItemsRequest: Request {
    var url: String { "till" }
    typealias ResponseType = [Item]
    
    
    func responseModel(data: Data) -> Result<[Item], CustomError> {
        let result = data.decoded(BaseResponse<[Item]>.self,
                                  decodingStrategy: .convertFromSnakeCase)
        switch result {
        case .success(let rules):
            return .success(rules.responseData)
        case .failure(let error):
            return .failure(error)
        }
    }
}
