//
//  PScreen1.swift
//  CyAlphaVantage
//
//  Created by Lucy on 15/01/21.
//

import Foundation
import UIKit

class PScreen2: NSObject {
    var arrModel1: [ModelSymbolDetail] = [ModelSymbolDetail]()
    var arrModel2: [ModelSymbolDetail] = [ModelSymbolDetail]()
    
    var wfVc: WfScreen2?
    
    var arrSymbol: ModelSearchResult = ModelSearchResult()
    var interactor: IScreen2?
    var vc: VCScreen2?
    
    let heightTableRow: CGFloat = 120.0
    let heightTableSearch: CGFloat = 70.0
    private var isData1: Bool = true
    var strSymbol1: String = "-"
    var strSymbol2: String = "-"
    
    func loadDataSymbolDetail(str: String) {
       
        self.vc?.displayLoading(isLoading: true)
        self.interactor?.fetchDefaultData(strSymbol: str, completionHandler: { (model) -> Void in
            self.vc?.displayLoading(isLoading: false)
            if model.count > 0 {
                if self.isData1 {
                    self.arrModel1 = model
                    self.isData1 = false
                    self.strSymbol1 = str
                } else {
                    self.arrModel2 = model
                    self.isData1 = true
                    self.strSymbol2 = str
                }
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
    
    func displayAlert(title: String? = nil, message: String? = nil) {
        var titleString = "Error"
        var messageString = message
        if title != nil {
            titleString = title!
        }
        if message != nil {
            messageString = message!
        }
        
        let alertController = UIAlertController(title: titleString, message: messageString, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
            action in
            // refetch data
           
        }))
        //self.vc?.present(alertController, animated: true, completion: nil)
    }
}
