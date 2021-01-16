//
//  PScreen1.swift
//  CyAlphaVantage
//
//  Created by Lucy on 15/01/21.
//

import Foundation
import UIKit

class PScreen1: NSObject {
    var wfVc: WfScreen1?
    
    var model: ModelSymbol?
    var interactor: IScreen1?
    var vc: VCScreen1?
    
    let heightTableRow: CGFloat = 50.0
    
    func configureURL(str: String) -> String {
        //https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&apikey=demo
        //https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol=IBM&outputsize=full&apikey=demo
        var strUrl = "https://www.alphavantage.co/query?"
        
        let param = DataManager.shared.getFunctionType()
        strUrl = strUrl + param
        
        let paramSymbol = str
        strUrl = strUrl + "&symbol=" + paramSymbol
        
        let paramOutput = DataManager.shared.getFunctionOutputSize()
        strUrl = strUrl + "&outputsize=" + paramOutput
        
        if !DataManager.shared.isDaily {
            strUrl = strUrl + "&interval=" + DataManager.shared.getFunctionInterval()
        }
        
        strUrl = strUrl + "&apikey=" + DataManager.shared.loadAPIKEY()
        return strUrl
    }
    
    func fetchDefaultData(strSymbol: String) {
        print("Fetching Data", self.configureURL(str: strSymbol))
        self.vc?.displayLoading(isLoading: true)
        guard let url = URL(string: self.configureURL(str: strSymbol)) else {
            return
        }
        
        return
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                print(error)
                return
            }
            
            // Parse JSON data
            if let data = data {
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    
                    print("data", jsonResult)
                } catch {
                    print(error)
                }
                
                
                // Reload table view
                OperationQueue.main.addOperation({
                    print("RETRIEVE DATA DONE")
                    self.vc?.displayLoading(isLoading: false)
                    
                })
            }
        })
        
        task.resume()
    }
     
}
