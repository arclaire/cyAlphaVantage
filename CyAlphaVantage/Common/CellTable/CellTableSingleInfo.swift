//
//  CellTableSingleInfo.swift
//  CyAlphaVantage
//
//  Created by Lucy on 15/01/21.
//

import UIKit

class CellTableSingleInfo: UITableViewCell {

    @IBOutlet weak var labelValueLow: UILabel!
    @IBOutlet weak var labelValueHigh: UILabel!
    @IBOutlet weak var labelValueOpen: UILabel!
    
    @IBOutlet weak var labelHour: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    func displayData(data: ModelSymbolDetail) {
        self.selectionStyle = .none
        if DataManager.shared.isDaily {
            self.labelDate.text = data.formatDate2()
            self.labelHour.text = ""
        } else {
            self.labelDate.text = data.formatDate()
            self.labelHour.text = data.formatHour()
        }
       
        self.labelValueLow.text = data.low
        self.labelValueHigh.text = data.high
        self.labelValueOpen.text = data.open
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
