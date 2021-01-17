//
//  CellTableSearchSymbol.swift
//  CyAlphaVantage
//
//  Created by Lucy on 17/01/21.
//

import UIKit

class CellTableSearchSymbol: UITableViewCell {

    @IBOutlet weak var labelSymbolDetail: UILabel!
    @IBOutlet weak var labelSymbol: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayData(data:ModelSymbol) {
        self.labelSymbol.text = data.symbol
        self.labelSymbolDetail.text = data.name
    }
    
}
