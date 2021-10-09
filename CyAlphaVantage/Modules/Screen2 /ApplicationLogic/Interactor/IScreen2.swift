//
//  IScreen2.swift
//  CyAlphaVantage
//
//  Created by Lucy on 15/01/21.
//

import Foundation

class IScreen2: NSObject {
    var isLoading: Bool = false
    var task: URLSessionTask?

    func configureURL(str: String) -> String {
        // https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&apikey=demo
        // https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol=IBM&outputsize=full&apikey=demo
        var strUrl = "https://www.alphavantage.co/query?"

        let param = "function=TIME_SERIES_DAILY_ADJUSTED"
        strUrl = strUrl + param

        let paramSymbol = str
        strUrl = strUrl + "&symbol=" + paramSymbol

        let paramOutput = DataManager.shared.getFunctionOutputSize()
        strUrl = strUrl + "&outputsize=" + paramOutput

        strUrl = strUrl + "&apikey=" + DataManager.shared.loadAPIKEY()
        return strUrl
    }

    func configureURLSearch(str: String) -> String {
        // https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=tesco&apikey=demo
        var strUrl = "https://www.alphavantage.co/query?"

        strUrl = strUrl + "function=SYMBOL_SEARCH"

        let paramSymbol = str
        strUrl = strUrl + "&keywords=" + paramSymbol

        strUrl = strUrl + "&apikey=" + DataManager.shared.loadAPIKEY()
        return strUrl
    }

    func fetchDefaultData(strSymbol: String, completionHandler: @escaping (_ data: [ModelSymbolDetail]) -> Void) {
        print("Fetching Data", configureURL(str: strSymbol))

        guard let url = URL(string: configureURL(str: strSymbol)) else {
            print("Error URL")
            return
        }
        var arrModel = [ModelSymbolDetail]()
        let request = URLRequest(url: url)
        task?.cancel()
        task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error -> Void in

            if let error = error {
                print(error)
                return
            }

            // Parse JSON data
            if let data = data {
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    print("JSON SCREEN 2", jsonResult)
                    var key: String = "Time Series (Daily)"

                    if let arrdata = jsonResult?.object(forKey: key) as? [String: Any] {
                        for data in arrdata {
                            var model = ModelSymbolDetail()
                            model.strDate = data.key
                            if let detail = data.value as? NSDictionary {
                                if let open = detail.object(forKey: "1. open") as? String {
                                    model.open = open
                                }
                                if let high = detail.object(forKey: "2. high") as? String {
                                    model.high = high
                                }
                                if let low = detail.object(forKey: "3. low") as? String {
                                    model.low = low
                                }
                            }
                            arrModel.append(model)
                        }
                    }
                    // Time Series (Daily)
                    // Time Series (60min)
                } catch {
                    print(error)
                }

                // Reload table view
                OperationQueue.main.addOperation {
                    completionHandler(self.sortData(data: arrModel))
                }
            }
        })

        task?.resume()
    }

    func fetchSearchData(str: String, completionHandler: @escaping (_ data: ModelSearchResult) -> Void) {
        print("Search Data", configureURLSearch(str: str))
        task?.cancel()

        isLoading = true
        guard let url = URL(string: configureURLSearch(str: str)) else {
            isLoading = false
            return
        }
        var arrSymbol = ModelSearchResult()

        let request = URLRequest(url: url)
        task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error -> Void in
            if let error = error {
                print(error)
                return
            }
            // Parse JSON data
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let dataSymbol = try decoder.decode(ModelSearchResult.self, from: data)
                    arrSymbol = dataSymbol
                    print("SEARCH RESULT", dataSymbol)

                } catch {
                    print(error)
                }

                // Reload table view
                OperationQueue.main.addOperation {
                    self.isLoading = false
                    completionHandler(arrSymbol)
                }
            }
        })

        task?.resume()
    }

    func sortData(data: [ModelSymbolDetail]) -> [ModelSymbolDetail] {
        let modelSorted = data.sorted(by: {
            $0.strDate! > $1.strDate!
        })

        return modelSorted
    }
}
