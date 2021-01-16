//
//  WfScreen1.swift
//  CyAlphaVantage
//
//  Created by Lucy on 15/01/21.
//

import Foundation
import UIKit
class WfScreen1: NSObject {
 
    var vc: VCScreen1?
    var wfRoot: WFRoot?
   
    var presenter : PScreen1?

    func presentVC(fromVC: UIViewController) {
        
    }
    
    func initiateVC() -> VCScreen1 {
        let storyboard = UIStoryboard.getMainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: ID_VC_SCREEN1) as! VCScreen1
        //viewController.eventHandler = self.presenter
        self.presenter?.vc = viewController
        return viewController
    }
    
    func presentVCToWindow(_ window: UIWindow) {
        let viewController = initiateVC()
        wfRoot?.showRootViewController(viewController, inWindow: window)
    }
    
    func navigateToScreen2() {
        let wfDetail = WfScreen2()

//        var manager = ManagerHeroes()
//        if let dataManager = self.presenter?.interactor?.dataManager {
//            manager = dataManager
//        }
        let interactor = IScreen2()
        let presenter = PScreen2()
        
//        presenter.interactor = interactor
//        presenter.interactor?.modelSelected = model
//        presenter.interactor?.model = self.presenter?.interactor?.model
//        presenter.vc = wfDetail.vc
//        presenter.wfVc = wfDetail
//        wfDetail.presenter = presenter
//
//        wfDetail.push(vc: (self.presenter?.vc)!, data: model)
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
