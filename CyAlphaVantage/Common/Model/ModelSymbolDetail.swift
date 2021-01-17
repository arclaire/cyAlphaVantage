//
//  ModelSymbolDetail.swift
//  CyAlphaVantage
//
//  Created by Lucy on 15/01/21.
//

import Foundation

struct ModelSearchResult: Codable {
    var bestMatches: [ModelSymbol]?
}

struct ModelSymbol: Codable, Error {
    var symbol: String?
    var name: String?
    var type: String?
    var currency: String?
    enum CodingKeys: String, CodingKey {
        case symbol  = "1. symbol"
        case name = "2. name"
        case type = "3. type"
        case currency = "8. currency"
    }
}

struct ModelSymbolDetail: Codable, Error {
    var open: String?//Double?
    var high: String?
    var low: String?
    var strDate: String?
    enum CodingKeys: String, CodingKey {
        case open  = "1. open"
        case high = "2. high"
        case low = "3. low"
    }
    
    func formatDate() -> String {
        let format = DateFormatter()
        var str = ""
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"//"EEEE, MMM d, yyyy h:mm a "//"yyyy-MM-dd HH:mm:ss"
        if let strd = self.strDate {
            if let date = format.date(from: strd) {
                format.dateFormat = "EEE, d MMM , yyyy"
                str = format.string(from: date)
            }
        }
        
        return str
    }
    
    func formatDate2() -> String {
        let format = DateFormatter()
        var str = ""
        format.dateFormat = "yyyy-MM-dd"//"EEEE, MMM d, yyyy h:mm a "//"yyyy-MM-dd HH:mm:ss"
        if let strd = self.strDate {
            if let date = format.date(from: strd) {
                format.dateFormat = "EEE, d MMM , yyyy"
                str = format.string(from: date)
            }
        }
        
        return str
    }
    
    func formatHour() -> String {
        let format = DateFormatter()
        var str = ""
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"//"EEEE, MMM d, yyyy h:mm a "//"yyyy-MM-dd HH:mm:ss"
        if let strd = self.strDate {
            if let date = format.date(from: strd) {
                format.dateFormat = "h:mm a"
                str = format.string(from: date)
            }
        }
        
        return str
    }
}
