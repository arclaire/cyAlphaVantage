//
//  WfScreen2.swift
//  CyAlphaVantage
//
//  Created by Lucy on 15/01/21.
//

import Foundation
import UIKit
class WfScreen2: NSObject {
    var presenter: PScreen2?
    var vc: VCScreen2?
    func push(vc: UIViewController) {
        self.vc = initiateVC()

        vc.navigationController?.pushViewController(self.vc!, animated: true)
    }

    func initiateVC() -> VCScreen2 {
        let storyboard = UIStoryboard.getMainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: ID_VC_SCREEN2) as! VCScreen2
        viewController.presenter = presenter
        presenter?.vc = viewController
        return viewController
    }
}
