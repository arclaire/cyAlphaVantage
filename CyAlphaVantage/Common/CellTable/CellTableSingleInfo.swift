//
//  CellTableSingleInfo.swift
//  CyAlphaVantage
//
//  Created by Lucy on 15/01/21.
//

import UIKit

class CellTableSingleInfo: UITableViewCell {
    @IBOutlet var labelValueLow: UILabel!
    @IBOutlet var labelValueHigh: UILabel!
    @IBOutlet var labelValueOpen: UILabel!

    @IBOutlet var labelHour: UILabel!
    @IBOutlet var labelDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    func displayData(data: ModelSymbolDetail) {
        selectionStyle = .none
        if DataManager.shared.isDaily {
            labelDate.text = data.formatDate2()
            labelHour.text = ""
        } else {
            labelDate.text = data.formatDate()
            labelHour.text = data.formatHour()
        }

        labelValueLow.text = data.low
        labelValueHigh.text = data.high
        labelValueOpen.text = data.open
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
