//
//  WfScreen3.swift
//  CyAlphaVantage
//
//  Created by Lucy on 15/01/21.
//

import Foundation
import UIKit
class WfScreen3: NSObject {

    var presenter: PScreen3?
    var vc: VCScreen3?
    func push(vc: UIViewController) {
        self.vc = self.initiateVC()
      
        vc.navigationController?.pushViewController(self.vc!, animated: true)
    }
    
    func initiateVC() -> VCScreen3 {
        let storyboard = UIStoryboard.getMainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: ID_VC_SCREEN3) as! VCScreen3
        viewController.presenter = self.presenter
        self.presenter?.vc = viewController
        return viewController
    }
}
