//
//  OrderPriceCell.swift
//  DietManagerManager
//
//  Created by AppleMac on 19/11/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit

class OrderPriceCell: UITableViewCell {

    @IBOutlet weak var subtotal : UILabel!
    @IBOutlet weak var taxLbl : UILabel!
    @IBOutlet weak var deliveryChargeLbl : UILabel!
    @IBOutlet weak var totalLbl : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
