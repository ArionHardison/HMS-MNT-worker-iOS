//
//  PurchasedListCell.swift
//  DietManagerManager
//
//  Created by AppleMac on 13/11/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit

class PurchasedListCell: UITableViewCell {

    @IBOutlet weak var ingredientName : UILabel!
    @IBOutlet weak var ingredientWeight : UILabel!
    @IBOutlet weak var ingredientSelectionImg : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func layoutSubviews() {
        ingredientSelectionImg?.image =  UIImage(named: "checked")
        ingredientSelectionImg?.image = ingredientSelectionImg?.image?.withRenderingMode(.alwaysTemplate)
        ingredientSelectionImg?.tintColor = .darkGray
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
