//
//  FetchPreviusItemsRequest.swift
//  wallet
//
//  Created by Kevin Campuzano on 5/2/22.
//

import Foundation
struct FetchPreviusItemsRequest: Request {
    var url: String { "till" }
    typealias ResponseType = [CashOutItem]
    
    
    func responseModel(data: Data) -> Result<[CashOutItem], CustomError> {
        let result = data.decoded(BaseResponse<[CashOutItem]>.self,
                                  decodingStrategy: .convertFromSnakeCase)
        switch result {
        case .success(let previousValues):
            return .success(previousValues.responseData)
        case .failure(let error):
            return .failure(error)
        }
    }
}
