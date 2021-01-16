//
//  AppDepedencies.swift
//  CyAlphaVantage
//
//  Created by Lucy on 15/01/21.
//

import Foundation
import UIKit
class AppDependencies {
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        let wf = AppDependencies.configureDependecy()
        wf.presentVCToWindow(window)
    }
    
    class func configureDependecy() -> WfScreen1 {
        let wf = WfScreen1()
     
        let rootWireframe = WFRoot()
        
        let presenter = PScreen1()
        //let datamanager = ManagerHeroes()
        let interactor = IScreen1()
        
        presenter.interactor = interactor
        presenter.wfVc = wf
        
        wf.presenter = presenter
        wf.wfRoot = rootWireframe
    
        
        return wf
    }
    
    deinit {
        print("deinit")
    }
}
