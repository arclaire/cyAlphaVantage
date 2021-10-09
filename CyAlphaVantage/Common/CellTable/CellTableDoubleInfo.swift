//
//  CellTableDoubleInfo.swift
//  CyAlphaVantage
//
//  Created by Lucy on 18/01/21.
//

import UIKit

class CellTableDoubleInfo: UITableViewCell {
    @IBOutlet var viewInfo2: UIView!
    @IBOutlet var viewInfo1: UIView!

    @IBOutlet var labelName1: UILabel!
    @IBOutlet var labelDate: UILabel!

    @IBOutlet var labelOpen1: UILabel!
    @IBOutlet var labelLow1: UILabel!
    @IBOutlet var labelName2: UILabel!

    @IBOutlet var labelLow2: UILabel!
    @IBOutlet var labelOpen2: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    func displayData1(model: ModelSymbolDetail?, strName: String, isDefault: Bool) {
        if !isDefault {
            labelName1.text = strName
            labelLow1.text = model?.low
            labelOpen1.text = model?.open
            labelDate.text = model?.formatDate2()
        } else {
            labelName1.text = "input Symbol 2"
            labelLow1.text = "0"
            labelOpen1.text = "0"
            labelDate.text = ""
        }
    }

    func displayData2(model: ModelSymbolDetail?, strName: String, isDefault: Bool) {
        if !isDefault {
            labelName2.text = strName
            labelLow2.text = model?.low
            labelOpen2.text = model?.open
        } else {
            labelName2.text = "input Symbol 2"
            labelLow2.text = "0"
            labelOpen2.text = "0"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
