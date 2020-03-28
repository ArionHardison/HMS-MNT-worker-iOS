//
//  ReasonsCell.swift
//  OrderAroundRestaurant
//
//  Created by Chan Basha on 13/03/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit

class ReasonsCell: UITableViewCell {

    @IBOutlet weak var buttonSelect: UIButton!
    @IBOutlet weak var labelReasons: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        labelReasons.font =  UIFont.regular(size: 14)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
