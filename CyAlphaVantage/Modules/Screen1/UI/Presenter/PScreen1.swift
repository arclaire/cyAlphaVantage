//
//  PScreen1.swift
//  CyAlphaVantage
//
//  Created by Lucy on 15/01/21.
//

import Foundation
import UIKit

class PScreen1: NSObject {
    var arrModel: [ModelSymbolDetail] = [ModelSymbolDetail]()
    
    var wfVc: WfScreen1?
    
    var arrSymbol: ModelSearchResult = ModelSearchResult()
    var interactor: IScreen1?
    var vc: VCScreen1?
    
    let heightTableRow: CGFloat = 100.0
    let heightTableSearch: CGFloat = 70.0
    
    func loadDataSymbolDetail(str: String) {
        self.arrModel.removeAll()
        self.vc?.displayLoading(isLoading: true)
        self.interactor?.fetchDefaultData(strSymbol: str, completionHandler: { (model) -> Void in
            self.vc?.displayLoading(isLoading: false)
            if model.count > 0 {
                self.arrModel = model
                self.vc?.reloadUI()
            }
        })
    }
    
    func loadSearch(str: String) {
        self.vc?.displayLoadingSearch(isLoading: true)
        self.interactor?.fetchSearchData(str: str, completionHandler: { (model) -> Void in
            self.arrSymbol = model
            self.vc?.displayLoadingSearch(isLoading: false)
            self.vc?.reloadUISearch()
        })
       
    }
    
    func navigateToCompare() {
        self.wfVc?.navigateToScreen2(model1: self.arrModel)
    }
    
    func navigateToSettings() {
        self.wfVc?.navigateToScreen3()
    }
}
