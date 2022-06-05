//
//  TempData.swift
//  wallet
//
//  Created by Kevin Campuzano on 31/5/22.
//

import Foundation

struct TempData {
    static func previusItemsJson() -> String {
        return """
        {
            "response_code":200,
            "response_message":"Processed Request",
            "response_data":[
                {
                    "nomination":0.01,
                    "quantity":10
                },
                {
                    "nomination":0.05,
                    "quantity":20
                },
                {
                    "nomination":0.1,
                    "quantity":19
                },
                {
                    "nomination":0.25,
                    "quantity":16
                 },
                {
                    "nomination":0.5,
                    "quantity":6
                },
                {
                    "nomination":1,
                    "quantity":15
                },
                {
                    "nomination":5,
                    "quantity":7
                },
                {
                    "nomination":10,
                    "quantity":2
                }
            ]
        }
        """
    }
}
