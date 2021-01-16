//
//  ModelSymbolDetail.swift
//  CyAlphaVantage
//
//  Created by Lucy on 15/01/21.
//

import Foundation


struct ModelSymbol: Codable, Error {
    var symbol: String?
    var name: String?
    var type: String?
    var currency: String?
   
}

struct ModelSymbolDetail: Codable, Error {
    var open: Double?
    var high: Double?
    var low: Double?
}
