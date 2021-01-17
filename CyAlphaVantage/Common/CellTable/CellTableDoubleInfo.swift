//
//  CellTableDoubleInfo.swift
//  CyAlphaVantage
//
//  Created by Lucy on 18/01/21.
//

import UIKit

class CellTableDoubleInfo: UITableViewCell {

    @IBOutlet weak var viewInfo2: UIView!
    @IBOutlet weak var viewInfo1: UIView!
    
    @IBOutlet weak var labelName1: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var labelOpen1: UILabel!
    @IBOutlet weak var labelLow1: UILabel!
    @IBOutlet weak var labelName2: UILabel!
    
    
    @IBOutlet weak var labelLow2: UILabel!
    @IBOutlet weak var labelOpen2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    func displayData1(model: ModelSymbolDetail?, strName: String, isDefault: Bool) {
        if !isDefault {
            self.labelName1.text = strName
            self.labelLow1.text = model?.low
            self.labelOpen1.text = model?.open
            self.labelDate.text = model?.formatDate2()
        } else {
            self.labelName1.text = "input Symbol 2"
            self.labelLow1.text = "0"
            self.labelOpen1.text = "0"
            self.labelDate.text = ""
        }
        
    }
    
    func displayData2(model: ModelSymbolDetail?, strName: String, isDefault: Bool) {
        if !isDefault {
            self.labelName2.text = strName
            self.labelLow2.text = model?.low
            self.labelOpen2.text = model?.open
        } else {
            self.labelName2.text = "input Symbol 2"
            self.labelLow2.text = "0"
            self.labelOpen2.text = "0"
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
