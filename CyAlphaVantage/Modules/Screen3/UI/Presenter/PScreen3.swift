//
//  PScreen3.swift
//  CyAlphaVantage
//
//  Created by Lucy on 15/01/21.
//

import Foundation

class PScreen3: NSObject {
    var wfVc: WfScreen3?
   
    var model: ModelSymbol?
    var interactor: IScreen3?
    var vc : VCScreen3?
    var arrInterval: [String] = ["1min", "5min", "15min", "30min", "60min"]
    var arrType: [String] = ["Daily", "IntraDay"]
    var isInterval: Bool = false
}
