//
//  CyAlphaVantageTests.swift
//  CyAlphaVantageTests
//
//  Created by Lucy on 15/01/21.
//

@testable import CyAlphaVantage
import XCTest

class CyAlphaVantageTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testCallFetchSearchSymbol() {
        let interactor = IScreen1()
        let str = "IBM"
        interactor.fetchSearchData(str: str, completionHandler: { model -> Void in
            if let _ = model.bestMatches {
                XCTAssert(true, "Call API success and retrieve response with valid model")

            } else {
                XCTAssert(false, "Model not retrieve")
            }
        })
    }

    func testCallFetchSymbolDetail() {
        let interactor = IScreen1()
        let str = "IBM"
        interactor.fetchDefaultData(strSymbol: str, completionHandler: { model -> Void in
            if model.count > 0 {
                XCTAssert(true, "Call API success and retrieve response with valid model")

            } else {
                XCTAssert(false, "Model not retrieve")
            }
        })
    }

    func testDataSave() {
        let strInterval = "10mins"
        DataManager.shared.saveInterval(str: strInterval)
        XCTAssert(true, "Save Interval to user default")
    }

    func testDataLoad() {
        let strload = DataManager.shared.getFunctionInterval()
        if strload.count > 0 {
            XCTAssert(true, "Load Data Success")
        } else {
            XCTAssert(false, "No Data")
        }
    }
}

"Error\(input)"
